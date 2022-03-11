let
    onCallStateChangeCallBackRef = [],
    onWebphoneStatusChangeCallBackRef = [],
    initParams,
    bodyWidget,
    btnWidget,
    icons,
    started = false,
    extensionState = "offline",
    muteState = false,
    holdState = false,
    protocol,
    widgetBody = {},
    widgetIcon = {}

if (localStorage.getItem("webphoneL5Modo") == "compacto") {
    widgetBody.size = {
        width: "250px",
        height: "200px"
    }
}

var eventMethod = window.addEventListener ?
    "addEventListener" :
    "attachEvent";
var eventer = window[eventMethod];
var messageEvent = eventMethod === "attachEvent" ?
    "onmessage" :
    "message";

eventer(messageEvent, function (e) {

    switch (e.data.evento) {

        case "webphoneStatus":
            if (e.data.parametros.status == "inicializando" && localStorage.getItem("webphoneL5Modo") == "compacto") {
                bodyWidget.contentWindow.postMessage({
                    evento: "webphoneL5Modo",
                    parametros: {
                        modo: "compacto"
                    }
                }, '*')
            }

            if (e.data.parametros.status == "carregado") {
                window.startAuth()
            }

            let newStatus

            if (onWebphoneStatusChangeCallBackRef.length > 0 && e.data.parametros.status !== "") {
                switch (e.data.parametros.status) {
                    case "inicializando":
                        newStatus = "initializing"
                        break;

                    case "registrando":
                        newStatus = "registering"
                        break;

                    case "erro ao registrar":
                        newStatus = "error to register"
                        break;

                    case "registrado":
                        newStatus = "registered"
                        break;

                    case "desregistrado":
                        newStatus = "unregistered"
                        break;

                    case "carregado":
                        newStatus = "loaded"
                        break;

                    default:
                        break;
                }
                if (e.data.parametros.status == "inicializando" || e.data.parametros.status == "registrando" || e.data.parametros.status == "erro ao registrar" || e.data.parametros.status == "registrado" || e.data.parametros.status == "carregado" || e.data.parametros.status == "desregistrado") onWebphoneStatusChangeCallBackRef.map((ref) => ref(newStatus))
            }

            break;

        case "callState":
            if (e.data.parametros.direction == "in") {
                if (!initParams.hideInterface) bodyWidget.style.display = "block"
                btnWidget.innerHTML = icons.close
            }

            if (e.data.parametros.state == "hold") holdState = true
            if (e.data.parametros.state == "unhold") holdState = false

            if (e.data.parametros.state == "mute") muteState = true
            if (e.data.parametros.state == "unmute") muteState = false

            if (e.data.parametros.state == "disconnected") {

                holdState = false
                muteState = false

                if (initParams.showCdr) {
                    fetchCallInfo(e.data.parametros.from, e.data.parametros.to).then((serverResponse) => {

                        let callEndedDate

                        if (serverResponse && serverResponse.data[0] && serverResponse.data[0].data_hora && serverResponse.data[0].duracao) {

                            let dataInicial = new Date(serverResponse.data[0].data_hora.split(" ")[0].split('/').reverse().join('/') + " " + serverResponse.data[0].data_hora.split(" ")[1]).getTime()

                            let dataFinal = dataInicial + (serverResponse.data[0].duracao * 1000)

                            let dataFinalObjetoDate = new Date(dataFinal)

                            callEndedDate = `${addZeroToBegining(dataFinalObjetoDate.getDate())}/${addZeroToBegining(dataFinalObjetoDate.getMonth() + 1)}/${addZeroToBegining(dataFinalObjetoDate.getFullYear())} ${addZeroToBegining(dataFinalObjetoDate.getHours())}:${addZeroToBegining(dataFinalObjetoDate.getMinutes())}:${addZeroToBegining(dataFinalObjetoDate.getSeconds())}`
                        }

                        let callState = Object.assign(e.data.parametros, {
                            CDR: {
                                startDate: (serverResponse && serverResponse.data[0] && serverResponse.data[0].data_hora) ? serverResponse.data[0].data_hora : "",
                                endDate: (callEndedDate) ? callEndedDate : "",
                                duration: (serverResponse && serverResponse.data[0] && serverResponse.data[0].duracao) ? serverResponse.data[0].duracao : "",
                                recordingLink: (serverResponse && serverResponse.data[0] && serverResponse.data[0].gravacao) ? serverResponse.data[0].gravacao : "",
                            }
                        })
                        if (onCallStateChangeCallBackRef.length > 0) onCallStateChangeCallBackRef.map((ref) => ref(callState))
                        return
                    })
                }

            }

            if (onCallStateChangeCallBackRef.length > 0) onCallStateChangeCallBackRef.map((ref) => ref(e.data.parametros))

            break;

        case "webphoneL5Modo":
            if (localStorage.getItem("webphoneL5Modo") == "compacto") {
                widgetBodySize = {
                    width: "250px",
                    height: "390px"
                }
                localStorage.setItem("webphoneL5Modo", "full")
            } else {
                widgetBodySize = {
                    width: "250px",
                    height: "200px"
                }
                localStorage.setItem("webphoneL5Modo", "compacto")
            }

            bodyWidget.style.width = widgetBodySize.width
            bodyWidget.style.height = widgetBodySize.height

            bodyWidget.contentWindow.postMessage({
                evento: "webphoneL5Modo",
                parametros: {
                    modo: localStorage.getItem("webphoneL5Modo")
                }
            }, '*')
            break;

        case "minimizarWebPhone":
            bodyWidget.style.display = "none"
            btnWidget.innerHTML = icons.phone
            break;

        case "erro":
            console.log(`ERRO WEBPHONE:\n${JSON.stringify(e.data.parametros, null, 4)}`)
            break;

        case "ramalStatus":
            extensionState = e.data.parametros.status
            break;

        case "returnFunctions":
            e.data.func({ isReturn: true, message: e.data.message })
            break;

        default:
            break;

    }
});

const handleWidgetClick = () => {
    if (bodyWidget.offsetWidth > 0 && bodyWidget.offsetHeight > 0) {
        bodyWidget.style.display = "none"
        btnWidget.innerHTML = icons.phone
    } else {
        if (!initParams.hideInterface) bodyWidget.style.display = "block"
        btnWidget.innerHTML = icons.close
    }
}

window.WebphoneL5 = {
    init: ({ extension, password, server, hideInterface = false, showCdr = false, iframeId = "widgetIframeWebphoneL5", btnId = "btnIframeWebphoneL5", body}) => {

        if (!started) {
            initParams = { extension, password, server, hideInterface, showCdr, iframeId, btnId }

            setProtocol(server)

            includeIframe({ iframeId: initParams.iframeId, btnId: initParams.btnId, body })

            if (initParams.hideInterface) {
                bodyWidget.style.display = "none"
                btnWidget.style.display = "none"
            }
            else {
                btnWidget.style.display = "flex"
            }

            window.startAuth = () => {
                bodyWidget.contentWindow.postMessage({
                    evento: "auth",
                    parametros: {
                        ramal: extension,
                        senha: password,
                        servidor: server
                    }
                }, '*')
            }
            started = true

            window.serverAddress = protocol + server.replace('http://', '').replace('https://', '');

        } else {
            initParams = { extension, password, server, hideInterface, showCdr, iframeId, btnId }
            bodyWidget.contentWindow.postMessage({
                evento: "auth",
                parametros: {
                    ramal: extension,
                    senha: password,
                    servidor: server
                }
            }, '*')
        }

    },
    getRamalState: () => {
        bodyWidget.contentWindow.postMessage({
            evento: "getWebphoneStatus"
        }, '*')
    },
    call: ({ number }) => {
        bodyWidget.contentWindow.postMessage({
            evento: "call",
            parametros: {
                numero: number,
            }
        }, '*')
    },
    hangup: () => {
        bodyWidget.contentWindow.postMessage({
            evento: "hangup"
        }, '*')
    },
    hold: () => {
        bodyWidget.contentWindow.postMessage({
            evento: "hold"
        }, '*')
    },
    mute: () => {
        bodyWidget.contentWindow.postMessage({
            evento: "mute"
        }, '*')
    },
    unhold: () => {
        bodyWidget.contentWindow.postMessage({
            evento: "unhold"
        }, '*')
    },
    unmute: () => {

        bodyWidget.contentWindow.postMessage({
            evento: "unmute"
        }, '*')


    },
    onCallStateChange: (callBack = null) => {
        if (callBack) onCallStateChangeCallBackRef.push(callBack)
    },
    onWebphoneStateChange: (callBack = null) => {
        if (callBack) onWebphoneStatusChangeCallBackRef.push(callBack)
    },
    getRamalState: () => {
        return extensionState
    },
    getHoldState: () => {
        return holdState
    },
    getMuteState: () => {
        return muteState
    },
    unregister: () => {
        bodyWidget.contentWindow.postMessage({
            evento: "unregister"
        }, '*')
    },
    accept: () => {
        bodyWidget.contentWindow.postMessage({
            evento: "acceptCall"
        }, '*')
    },
    reject: () => {
        bodyWidget.contentWindow.postMessage({
            evento: "rejectCall"
        }, '*')
    }
}

const fetchCallInfo = (from, to) => {
    return new Promise((resolve) => {

        var raw = JSON.stringify({
            "email": "pops@teste.com.br",
            "src": from,
            "dst": to,
            "server": window.serverAddress
        });

        var requestOptions = {
            method: 'POST',
            body: raw
        };

        fetch("https://dev.gocall.l5.com.br/index.php/iframe", requestOptions)
            .then(response => response.text())
            .then(result => {
                return resolve(JSON.parse(result))
            })
            .catch(error => console.log('error', error));
    })

}

const includeIframe = ({ iframeId, btnId, body }) => {


    widgetBody = {
        id: iframeId,
        size: {
            width: "250px",
            height: "390px"
        },
        position: {
            top: "",
            bottom: "4rem",
            right: "3.5rem",
            left: ""
        },
        borderColor: "#000"
    }

    widgetIcon = {
        id: btnId,
        backgroundColor: "#1e5396",
        iconColor: "#FFF",
        position: {
            top: "",
            bottom: "1rem",
            right: "1rem",
            left: ""
        },
        size: {
            width: "3rem",
            height: "3rem"
        },
    }

    icons = {
        close: `<svg style="stroke: ${widgetIcon.iconColor}; width: 17px;" viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>`,
        phone: `<svg style="fill: ${widgetIcon.iconColor}; width: 17px;" viewBox="0 0 24 24" width="24" height="24" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>`
    }

    btnWidget = document.createElement("div")
    btnWidget.innerHTML = icons.phone
    btnWidget.id = widgetIcon.id
    btnWidget.style.backgroundColor = widgetIcon.backgroundColor
    btnWidget.style.width = widgetIcon.size.width
    btnWidget.style.height = widgetIcon.size.height
    btnWidget.style.display = "flex"
    btnWidget.style.justifyContent = "center"
    btnWidget.style.alignItems = "center"
    btnWidget.style.borderRadius = "9999px"
    btnWidget.style.zIndex = "9999"
    btnWidget.style.position = "fixed"
    btnWidget.style.cursor = "pointer"
    btnWidget.style.display = "none"

    Object.keys(widgetIcon.position).map(e => btnWidget.style[e] = widgetIcon.position[e])

    bodyWidget = document.createElement("iframe")
    bodyWidget.id = widgetBody.id
    bodyWidget.style.width = widgetBody.size.width
    bodyWidget.style.height = widgetBody.size.height
    bodyWidget.style.borderRadius = ".25rem"
    bodyWidget.style.zIndex = "9999"
    bodyWidget.style.position = "fixed"
    bodyWidget.style.border = `solid 1px ${widgetBody.borderColor}`
    bodyWidget.style.display = "none"
    bodyWidget.allow = "camera;microphone;"
    bodyWidget.src = "https://dev.gocall.l5.com.br/iframe/index.html"

    Object.keys(widgetBody.position).map(e => bodyWidget.style[e] = widgetBody.position[e])

    btnWidget.addEventListener("click", function () {
        handleWidgetClick()
    }, false);

    btnWidget.appendChild(bodyWidget);

    body.appendChild(btnWidget)
}

const addZeroToBegining = (toAdd) => {
    if (toAdd.toString().split('').length == 1) {
        toAdd = "0" + toAdd.toString()
    }
    return toAdd
}

const setProtocol = (url) => {

    if (localStorage.getItem(url) == "https://" || localStorage.getItem(url) == "http://") {
        protocol = localStorage.getItem(url)
    } else {
        let key = url;
        url = url.replace('http://', '').replace('https://', '');
        /** verifica se a url Ã© um ip */
        let _uri = url.replaceAll('.', '');
        let pattern = /[a-z]{1,}/ig;
        let is_ip = pattern.test(_uri);
        if (!is_ip) {
            protocol = 'http://';
            insertLocalStorage(key, protocol);
        }
        else {
            fetch('https://' + url)
                .then((response) => {
                    protocol = 'http://';
                    if (response.status == 200) protocol = 'https://';
                    insertLocalStorage(key, protocol);
                })
                .catch(function (error) {
                    protocol = 'http://';
                    insertLocalStorage(key, protocol);
                });
        }
    }
}

const insertLocalStorage = (key, value) => {
    if (typeof (Storage) !== "undefined") {
        localStorage.setItem(key, value);
    }
}