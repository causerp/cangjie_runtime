/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file defines the Transaction related interface.
 */

package std.database.sql

/**
 * Transaction isolation defines when and how the results of an operation in a transaction are visible to other concurrent transaction operations in a database system.
 */
public enum TransactionIsoLevel <: ToString & Hashable & Equatable<TransactionIsoLevel> {
    // unspecified transaction isolation level, the behavior depends on a specific database server.
    | Unspecified
    // The transaction waits until rows write-locked by other transactions are unlocked; this prevents it from reading any "dirty" data.
    | ReadCommitted
    // Transactions are not isolated from each other. 
    | ReadUncommitted
    // The transaction waits until rows write-locked by other transactions are unlocked; this prevents it from reading any "dirty" data.
    | RepeatableRead
    // Snapshot isolation avoids most locking and blocking by using row versioning. 
    | Snapshot
    // The transaction waits until rows write-locked by other transactions are unlocked; this prevents it from reading any "dirty" data.
    | Serializable
    // Linearizability is relevant when you are looking at a subset of operations on a single object (i.e. a db row or a nosql record).
    | Linearizable
    // The pending changes from more highly isolated transactions cannot be overwritten.
    | Chaos

    public func toString(): String {
        match (this) {
            case Unspecified => "Unspecified"
            case ReadCommitted => "Read Committed"
            case ReadUncommitted => "Read Uncommitted"
            case RepeatableRead => "Repeatable Read"
            case Snapshot => "Snapshot"
            case Serializable => "Serializable"
            case Linearizable => "Linearizable"
            case Chaos => "Chaos"
        }
    }

    public operator func ==(rhs: TransactionIsoLevel): Bool {
        match ((this, rhs)) {
            case (Unspecified, Unspecified) => true
            case (ReadCommitted, ReadCommitted) => true
            case (ReadUncommitted, ReadUncommitted) => true
            case (RepeatableRead, RepeatableRead) => true
            case (Snapshot, Snapshot) => true
            case (Serializable, Serializable) => true
            case (Linearizable, Linearizable) => true
            case (Chaos, Chaos) => true
            case _ => false
        }
    }

    public operator func !=(rhs: TransactionIsoLevel): Bool {
        return !(this == rhs)
    }

    public func hashCode(): Int64 {
        return this.toString().hashCode()
    }
}

/**
 * Transactional read/write mode.
 */
public enum TransactionAccessMode <: ToString & Hashable & Equatable<TransactionAccessMode> {
    // unspecified transaction access mode, the behavior depends on a specific database server.
    | Unspecified
    // read-write mode
    | ReadWrite
    // readonly mode
    | ReadOnly

    public func toString(): String {
        match (this) {
            case Unspecified => "Unspecified"
            case ReadWrite => "Read Write"
            case ReadOnly => "Read Only"
        }
    }

    public operator func ==(rhs: TransactionAccessMode): Bool {
        match ((this, rhs)) {
            case (Unspecified, Unspecified) => true
            case (ReadWrite, ReadWrite) => true
            case (ReadOnly, ReadOnly) => true
            case _ => false
        }
    }

    public operator func !=(rhs: TransactionAccessMode): Bool {
        return !(this == rhs)
    }

    public func hashCode(): Int64 {
        return this.toString().hashCode()
    }
}

/**
 * Deferred Mode for Transactions.
 */
public enum TransactionDeferrableMode <: ToString & Hashable & Equatable<TransactionDeferrableMode> {
    // Unspecified transaction defer mode, the behavior depends on a specific database server.
    | Unspecified
    // DEFERRABLE
    | Deferrable
    // NOT_DEFERRABLE
    | NotDeferrable

    public func toString(): String {
        match (this) {
            case Unspecified => "Unspecified"
            case Deferrable => "Deferrable"
            case NotDeferrable => "Not Deferrable"
        }
    }

    public operator func ==(rhs: TransactionDeferrableMode): Bool {
        match ((this, rhs)) {
            case (Unspecified, Unspecified) => true
            case (Deferrable, Deferrable) => true
            case (NotDeferrable, NotDeferrable) => true
            case _ => false
        }
    }

    public operator func !=(rhs: TransactionDeferrableMode): Bool {
        return !(this == rhs)
    }

    public func hashCode(): Int64 {
        return this.toString().hashCode()
    }
}

/**
 * Defines the core behavior of database transactions.
 */
public interface Transaction {
    /**
     * Transaction isolation.
     */
    mut prop isoLevel: TransactionIsoLevel

    /**
     * Transactional read/write mode.
     */
    mut prop accessMode: TransactionAccessMode

    /**
     * Deferred Mode for Transactions.
     */
    mut prop deferrableMode: TransactionDeferrableMode

    /**
     * Starts a database transaction.
     * SqlException - Parallel transactions are not supported.
     */
    func begin(): Unit

    /**
     * Commits the database transaction.
     * SqlException - An error occurred while trying to commit the transaction.
     */
    func commit(): Unit

    /**
     * Rolls back a transaction from a pending state.
     * SqlException - An error occurred while trying to rollback the transaction.
     */
    func rollback(): Unit

    /**
     * Rolls back a transaction from a pending state, and specifies the transaction or savepoint name.
     * SqlException - An error occurred while trying to rollback the transaction.
     */
    func rollback(savePointName: String): Unit

    /**
     * Creates a savepoint in the transaction that can be used to roll back a part of the transaction, and specifies the savepoint name.
     * SqlException - An error occurred while trying to create the savepoint.
     */
    func save(savePointName: String): Unit

    /**
     * Destroys a savepoint previously defined in the current transaction. This allows the system to reclaim some resources before the transaction ends.
     * SqlException - An error occurred while trying to release the savepoint.
     */
    func release(savePointName: String): Unit
}
