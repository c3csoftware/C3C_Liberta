import { LightningElement } from 'lwc';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';

import rtc from '@salesforce/resourceUrl/RTC';

export default class RTCPlugin extends LightningElement
{
    connectedCallback() {
        Promise.all([
            loadScript(this, rtc)
        ]).then(() => {
            console.log('LOADED');


            WebphoneL5.init( {
                "extension":"6291",
                "password":"L1b3rt@2021",
                "server":"https://liberta.callbox.com.br"
            });
        });
    }
}