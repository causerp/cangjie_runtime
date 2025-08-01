/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.database.sql

/**
 * Predefined SQL option name and value. If extension is required, do not conflict with these names and values.
 */
public class SqlOption {
    /**
     * URL, which is usually used for database connection strings in SQL api.
     */
    public static const URL: String = "url"

    /**
     * Host, host name or IP address of the database server
     */
    public static const Host: String = "host"

    /**
     * Username, user name for connecting to the database
     */
    public static const Username: String = "username"

    /**
     * Password, password for connecting to the database
     */
    public static const Password: String = "password"

    /**
     * Driver, database driver name, for example, postgres and opengauss.
     */
    public static const Driver: String = "driver"

    /**
     * Database, database Name
     */
    public static const Database: String = "database"

    /**
     * Encoding, encoding type of the database character set.
     */
    public static const Encoding: String = "encoding"

    /**
     * ConnectionTimeout, timeout interval of the connect operation, in milliseconds.
     */
    public static const ConnectionTimeout: String = "connection_timeout"

    /**
     * UpdateTimeout, timeout interval of the update operation, in milliseconds.
     */
    public static const UpdateTimeout: String = "update_timeout"

    /**
     * QueryTimeout, Timeout interval of the query operation, in milliseconds.
     */
    public static const QueryTimeout: String = "query_timeout"

    /**
     * FetchRows, Specifies the number of rows to fetch from the database when additional rows need to be fetched
     */
    public static const FetchRows: String = "fetch_rows"

    /**
     * SSLMode, transport layer encryption mode
     */
    public static const SSLMode: String = "ssl.mode"
    /**
     * SSLModePreferred, value for SSLMode, first try an SSL connection; if that fails, try a non-SSL connection.
     */
    public static const SSLModePreferred: String = "ssl.mode.preferred"
    /**
     * SSLModeDisabled, value for SSLMode, Establish an unencrypted connection.
     */
    public static const SSLModeDisabled: String = "ssl.mode.disabled"
    /**
     * SSLModeRequired, value for SSLMode, only try an SSL connection. If a root CA file is present, verify the certificate in the same way as if verify-ca was specified.
     */
    public static const SSLModeRequired: String = "ssl.mode.required"
    /**
     * SSLModeVerifyCA, value for SSLMode, only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
     */
    public static const SSLModeVerifyCA: String = "ssl.mode.verify_ca"
    /**
     * SSLModeVerifyFull, value for SSLMode, only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.
     */
    public static const SSLModeVerifyFull: String = "ssl.mode.verify_full"

    /**
     * SSLCA, specifies the name of a file containing SSL certificate authority (CA) certificate(s).
     */
    public static const SSLCA: String = "ssl.ca"

    /**
     * SSLCert, specifies the file name of the client SSL certificate.
     */
    public static const SSLCert: String = "ssl.cert"

    /**
     * SSLKey, specifies the location for the secret key used for the client certificate.
     */
    public static const SSLKey: String = "ssl.key"

    /**
     * SSLKeyPassword, the password for the secret key specified in SSLKey
     */
    public static const SSLKeyPassword: String = "ssl.key.password"

    /**
     * SSLSni, setting the value "Server Name Indication" (SNI) on SSL-enabled connections, in Bool type
     */
    public static const SSLSni: String = "ssl.sni"

    /**
     * Tls12Ciphersuites, The list of permissible encryption ciphers for connections that use TLS protocols up through TLSv1.2.
     * The value is a list of zero or more colon-separated ciphersuite names.
     * For example: "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256:TLS_DHE_RSA_WITH_AES_128_CBC_SHA"
     */
    public static const Tls12Ciphersuites: String = "tls1.2.ciphersuites"

    /**
     * Tls13Ciphersuites, specifies which ciphersuites the client permits for encrypted connections that use TLSv1.3.
     * The value is a list of zero or more colon-separated ciphersuite names.
     * For example: "TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
     */
    public static const Tls13Ciphersuites: String = "tls1.3.ciphersuites"

    /**
     * TlsVersion, specifies the TLS protocols the client permits for encrypted connections.
     * The value is a list of one or more comma-separated protocol versions.
     * For example:"TLSv1.2,TLSv1.3"
     */
    public static const TlsVersion: String = "tls.version"
}
