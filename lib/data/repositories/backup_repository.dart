import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../database/app_database.dart';
import '../models/entry.dart';
import '../models/entry_group.dart';
import '../models/currency.dart';
import '../../core/constants.dart';

class BackupRepository {
  final AppDatabase _db;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  BackupRepository(this._db)
      : _firestore = FirebaseFirestore.instance,
        _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  bool get isSignedIn => _auth.currentUser != null;

  Future<void> backupToFirestore() async {
    final uid = _userId;
    if (uid == null) throw Exception('Not signed in');

    try {
      final batch = _firestore.batch();
      final userRef = _firestore.collection('users').doc(uid);

      // Backup entries
      final entries = await _db.entriesDao.watchAllEntries().first;
      for (final entry in entries) {
        final ref = userRef
            .collection(AppConstants.firestoreEntriesCollection)
            .doc(entry.id);
        batch.set(ref, entry.toMap());
      }

      // Backup groups
      final groups = await _db.groupsDao.watchAllGroups().first;
      for (final group in groups) {
        final ref = userRef
            .collection(AppConstants.firestoreGroupsCollection)
            .doc(group.id);
        batch.set(ref, group.toMap());
      }

      // Backup currencies
      final currencies = await _db.currenciesDao.getAllCurrencies();
      for (final currency in currencies) {
        final ref = userRef
            .collection(AppConstants.firestoreCurrenciesCollection)
            .doc(currency.code);
        batch.set(ref, currency.toMap());
      }

      // Update metadata
      batch.set(
          userRef,
          {
            'lastBackupAt': DateTime.now().toIso8601String(),
            'entriesCount': entries.length,
            'groupsCount': groups.length,
          },
          SetOptions(merge: true));

      await batch.commit();
    } catch (e) {
      debugPrint('Backup failed: $e');
      rethrow;
    }
  }

  Future<DateTime?> getLastBackupTime() async {
    final uid = _userId;
    if (uid == null) return null;

    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      final data = doc.data();
      if (data == null) return null;
      final ts = data['lastBackupAt'] as String?;
      if (ts == null) return null;
      return DateTime.tryParse(ts);
    } catch (e) {
      debugPrint('Get last backup time failed: $e');
      return null;
    }
  }

  Future<void> restoreFromFirestore() async {
    final uid = _userId;
    if (uid == null) throw Exception('Not signed in');

    try {
      final userRef = _firestore.collection('users').doc(uid);

      // Restore groups first (entries depend on groups)
      final groupsSnap = await userRef
          .collection(AppConstants.firestoreGroupsCollection)
          .get();
      for (final doc in groupsSnap.docs) {
        final group = EntryGroupModel.fromMap(
          Map<String, dynamic>.from(doc.data()),
        );
        await _db.groupsDao.insertGroup(group).catchError((_) async {
          await _db.groupsDao.updateGroup(group);
        });
      }

      // Restore entries
      final entriesSnap = await userRef
          .collection(AppConstants.firestoreEntriesCollection)
          .get();
      for (final doc in entriesSnap.docs) {
        final entry = EntryModel.fromMap(Map<String, dynamic>.from(doc.data()));
        await _db.entriesDao.insertEntry(entry).catchError((_) async {
          await _db.entriesDao.updateEntry(entry);
        });
      }

      // Restore currencies
      final currenciesSnap = await userRef
          .collection(AppConstants.firestoreCurrenciesCollection)
          .get();
      for (final doc in currenciesSnap.docs) {
        final currency = CurrencyModel.fromMap(
          Map<String, dynamic>.from(doc.data()),
        );
        await _db.currenciesDao.upsertCurrency(currency);
      }
    } catch (e) {
      debugPrint('Restore failed: $e');
      rethrow;
    }
  }
}
