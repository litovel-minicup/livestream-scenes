import QtQuick 2.9
import QtQuick.Window 2.2
import "../component"

Item {
    id: component

    visible: true
    width: engine.width
    height: engine.height

    FontLoader {
        // High School USA Sans
        source: "../font/mc_font.otf"
    }

    FontLoader {
        // Saira Black
        source: "../font/Saira-Black.ttf"
    }

    FontLoader {
        // Saira
        source: "../font/Saira-Regular.ttf"
    }

    Connections {
        target: matchDataManager
        onShowSocialMediasReq: socialMedias.state = "full"
        onHideSocialMediasReq: socialMedias.state = "hidden"
    }

    SocialMedias {
        id: socialMedias

        state: "hidden"
        width: parent.width
        height: width / 28.5
    }
}
