#ifndef __SETTINGEX_H_BY_YFGZ_20150806__
#define __SETTINGEX_H_BY_YFGZ_20150806__

#include <QCoreApplication>
#include <QSettings>
#include <QDebug>

// Function: Wrapper QSettings for write redirection and read default setting from configMain
// Format: IniFormat, UTF-8
namespace QIM 
{
class C_QSettingEx
{
public:
    C_QSettingEx(const QString& configMain = qApp->applicationDirPath().append('/') + qApp->applicationName() + ".ini" )
        : m_setting(configMain, QSettings::IniFormat)
        , m_settingWrite(QSettings::IniFormat, QSettings::UserScope, qApp->organizationName(), qApp->applicationName() )
    {
       _init();
    }

    C_QSettingEx(const QString& configWrite, const QString& configMain = qApp->applicationDirPath().append('/') + qApp->applicationName() + ".ini" )
        : m_setting(configMain, QSettings::IniFormat)
        , m_settingWrite(configWrite, QSettings::IniFormat )
    {
        _init();
    }

    ~C_QSettingEx()
    {
        m_settingWrite.sync();
    }

    void setValue(const QString &key, const QVariant &value)
    {
        m_settingWrite.setValue(key, value);
    }

    QVariant value(const QString &key, const QVariant &defaultValue = QVariant(), bool onlyMain = false) const
    {
        if ( onlyMain == false )
        {
            QVariant ret = m_settingWrite.value(key, defaultValue);
            if ( ret.isValid() )
            {
                return ret;
            }
        }

        return m_setting.value(key, defaultValue);
    }

    void clear()
    {
        m_settingWrite.clear();
    }

    void sync()
    {
        m_settingWrite.sync();
    }

    void remove(const QString &key)
    {
        m_settingWrite.remove(key);
    }

    QString fileName(bool isMain = false) const
    {
        if ( isMain )
            return m_setting.fileName();

        return m_settingWrite.fileName();
    }

    // group
    void beginGroup(const QString &prefix)
    {
       m_setting.beginGroup(prefix);
       m_settingWrite.beginGroup(prefix);
    }

    void endGroup()
    {
       m_setting.endGroup();
       m_settingWrite.endGroup();
    }

    QString group() const
    {
        return m_settingWrite.group();
    }

private:
    inline void _init()
    {
        m_setting.setIniCodec("UTF-8");
        m_setting.setFallbacksEnabled(m_setting.isWritable());

        m_settingWrite.setIniCodec("UTF-8");
        m_settingWrite.setFallbacksEnabled(true);

        qDebug() << "Main configration file: " << m_setting.fileName();
        qDebug() << "User configration file: " << m_settingWrite.fileName();
    }

private:
    QSettings m_setting;        // Main configration from install location
    QSettings m_settingWrite;   // Write configration in user location
};

// ****************************************************************************
// Defined the const key/group name in QIM here
// QIM ========================================================================
#define  KEY_QIM                    "QIM"                     // Application key
# define LANGUAGE                   "Language"                // Application language
# define COMPANY                    "Company"                 // Company name
# define DOWNLOAD_URL               "DownloadUrl"             // The installer download URL
# define FEEDBACK_URL               "FeedbackUrl"             // The feedback URL

# define PLUGINS_DIR				"PluginsDir"			  // Plugins directory, at the install location subdir of "Plugins"
# define APP_DATA_DIR				"AppDataDir"			  // Application data directory, default as QStandardPaths::AppDataLocation\qIM, always end by 'qIM', user maybe relocation it
# define APP_DOC_DIR				"AppDocDir"				  // Application document directory, default as QStandardPaths::DocumentsLocation\qIM, always end by 'qIM', user maybe relocation it 

// Servers ====================================================================
#define KEY_SERVER_SETTING          "Server"
// IM servers
# define CONNECT_TYPE               "ConnectType"             // Connect type: 0 - IP, 1 - domain
# define SET_MODE                   "SetMode"                 // Set mode: 0 - disable, 1 - only IP, 2 - only domain, 3 - IP and domain
# define MAIN_IP                    "Main.IP"                 // Main IP
# define MAIN_PORT                  "Main.Port"               // Main port
# define MAIN_DOMAIN                "Main.Domain"             // Main domain
# define REMOTE_IP                  "Remote.IP"               // Remote IP
# define REMOTE_PORT                "Remote.Port"             // Remote port
# define REMOTE_DOMAIN              "Remote.Domain"           // Remote domain

// P2P server
# define P2P_IP                     "P2P.IP"                  // P2P IP
# define P2P_PORT                   "P2P.Port"                // P2P port

// File server
# define FILE_UPLOAD_URL            "File.UploadUrl"          // File upload URL
# define FILE_UPLOAD_IP             "File.UploadIP"           // File upload IP
# define FILE_DOWNLOAD_URL          "File.DownloadUrl"        // File download URL
# define FILE_DOWNLOAD_IP           "File.DownloadIP"         // File download IP

// Image server
# define IMAGE_UPLOAD_URL           "Image.UploadUrl"         // Image upload URL
# define IMAGE_UPLOAD_IP            "Image.UploadIP"          // Image upload IP
# define IMAGE_DOWNLOAD_URL         "Image.DownloadUrl"       // Image download URL
# define IMAGE_DOWNLOAD_IP          "Image.DownloadIP"        // Image download IP

// Head image server
# define HEAD_UPLOAD_URL            "Head.UploadUrl"          // Head upload URL
# define HEAD_UPLOAD_IP             "Head.UploadIP"           // Head upload IP
# define HEAD_DOWNLOAD_URL          "Head.DownloadUrl"        // Head download URL
# define HEAD_DOWNLOAD_IP           "Head.DownloadIP"         // Head download IP

// File breakpoint resume server
# define BFILE_UPLOAD_URL           "BFile.UploadUrl"         // Breakpoint resume file upload URL
# define BFILE_UPLOAD_IP            "BFile.UploadIP"          // Breakpoint resume file upload IP
# define BFILE_DOWNLOAD_URL         "BFile.DownloadUrl"       // Breakpoint resume file download URL
# define BFILE_DOWNLOAD_IP          "BFile.DownloadIP"        // Breakpoint resume file download IP
# define BFILE_TOKEN_UPLOAD_URL     "BFile.Token.UploadUrl"   // Breakpoint resume file token upload URL
# define BFILE_TOKEN_UPLOAD_IP      "BFile.Token.UploadIP"    // Breakpoint resume file token IP

// Image breakpoint resume server
# define BIMAGE_UPLOAD_URL          "BImage.UploadUrl"        // Breakpoint resume image upload URL
# define BIMAGE_UPLOAD_IP           "BImage.UploadIP"         // Breakpoint resume image upload IP
# define BIMAGE_DOWNLOAD_URL        "BImage.DownloadUrl"      // Breakpoint resume image download URL
# define BIMAGE_DOWNLOAD_IP         "BImage.DownloadIP"       // Breakpoint resume image download IP
# define BIMAGE_TOKEN_UPLOAD_URL    "BImage.Token.UploadUrl"  // Breakpoint resume image upload URL
# define BIMAGE_TOKEN_UPLOAD_IP_    "BImage.Token.UploadIP"   // Breakpoint resume image upload IP

// Setting ====================================================================

//

} // namespace QIM

#endif // __SETTINGEX_H_BY_YFGZ_20150806__

