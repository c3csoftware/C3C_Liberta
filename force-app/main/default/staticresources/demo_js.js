require(['dojo/ready', 'dojox/cometd', 'dojo/dom', 'dojo', 'dojo/query'], function(ready){
    ready(function(){

        //Callbacks function

        if(!window.onChangeConnection)
            window.onChangeConnection = (message) => {};
        if(!window.onChangeSubscription)
            window.onChangeSubscription = (message) => {};
        if(!window.onChangePushEvent)
            window.onChangePushEvent = (message) => {};

        dojo.removeClass('join', 'hidden');
        dojo.addClass('joined', 'hidden');

        var channels = [];
        var connected = false;   
        var cometd = dojox.cometd;

        function metaConnectListener(message) 
        {
            var wasConnected = connected;
            connected = message.successful;
            if (!wasConnected && connected) 
            {                
                console.log('DEBUG: Connection Successful : '+JSON.stringify(message)+'');   
            } 
            else if (wasConnected && !connected) 
            {
                console.log('DEBUG: Disconnected from the server'+JSON.stringify(message)+'');
            }

            window.onChangeConnection(message);
        }

        function metaHandshakeListener(message) {
            if (message.successful) {
                console.log(' DEBUG: Handshake Successful: '+JSON.stringify(message)+' ');
            } else {
                console.log('DEBUG: Handshake Unsuccessful: '+JSON.stringify(message)+' ');
            }
        }

        function metaDisconnectListener(message) {
            console.log('DEBUG: /meta/disconnect message: '+JSON.stringify(message)+' ');
        }

        function metaSubscribeListener(message) {  
            if (message.successful) {
                console.log('DEBUG: Subscribe Successful : '+JSON.stringify(message)+' ');
            dojo.addClass('join', 'hidden');
            dojo.removeClass('joined', 'hidden');
            } else {
                console.log('DEBUG: Subscribe Unsuccessful : '+JSON.stringify(message)+' ');                
            }    

            window.onChangeSubscription(message);
        };

        function metaUnSubscribeListener(message) {  
            if (message.successful) {
                console.log('DEBUG: Unsubscribe Successful '+JSON.stringify(message)+' ');
            dojo.removeClass('join', 'hidden');
            dojo.addClass('joined', 'hidden');
            } else {
                console.log('DEBUG: Unsubscribe Unsuccessful '+JSON.stringify(message)+' ');                
            }
        };

        function metaUnSucessfulListener(message) {  
            console.log('DEBUG:  /meta/unsuccessful Error: '+JSON.stringify(message)+' ');
        };

        //Inscrever em evento PushTopic
        function subscribe(topic) {  
            let indexChannel = channels.findIndex(x => x.topic == topic);

            if(indexChannel >= 0)
                return;

            if(connected) 
            {
                if (topic == null) 
                {
                    console.log('Please enter a topic');
                    return;
                }	

                let topicsubscription = cometd.subscribe(topic, receive);	
                channels.push({
                    topic,
                    topicsubscription
                });
            } else {
                console.log('DEBUG: Cannot subscribe due to unsuccessful connection');
            }                
        }

        function unsubscribe(topic) {
            let indexChannel = channels.findIndex(x => x.topic == topic);

            if(indexChannel >= 0) 
            {
                cometd.unsubscribe(channels[indexChannel].topicsubscription);
                channels.splice(indexChannel, 1);
            }
        }

        window.pushTopicEventSubscribe = (topic) => {
            subscribe(topic);
        };

        window.pushTopicEventUnsubscribe = (topic) => {
            unsubscribe(topic);
        };

        //Onde evento é capturado
        function receive(message) {
            var datastream = dojo.byId('datastream');
            data = message.data; 
            console.log('DEBUG EVENT: '+JSON.stringify(data));
            window.onChangePushEvent(message);
        }

        cometd.websocketEnabled = false;
        var auth = 'OAuth ' + token;
        var cometdURL = window.location.protocol+'//'+window.location.hostname+ (null != window.location.port ? (':'+window.location.port) : '') +'/cometd/40.0/';

        cometd.configure({
            url: cometdURL,
            requestHeaders: { Authorization: auth}
        });

        cometd.addListener('/meta/connect', metaConnectListener);

        cometd.addListener('/meta/handshake', metaHandshakeListener);

        cometd.addListener('/meta/disconnect', metaDisconnectListener);

        cometd.addListener('/meta/subscribe', metaSubscribeListener);

        cometd.addListener('/meta/unsubscribe', metaUnSubscribeListener);

        cometd.addListener('/meta/unsuccessful', metaUnSucessfulListener);

        cometd.handshake();	
    });
});
