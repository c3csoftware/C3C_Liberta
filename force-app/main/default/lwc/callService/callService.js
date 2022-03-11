import { api, LightningElement } from 'lwc';
import callServiceMethod from '@salesforce/apex/C3C_APP_InterfaceApplicationController.callServiceMethod';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class CallService extends LightningElement 
{
    @api service;
    listContracts = [];

    @api
    setParams(params)
    {
        let lastContract = this.getLastContract();

        lastContract.params = params;
        this.setLastContract(lastContract);
    }

    @api
    enablePath()
    {
        let lastContract = this.getLastContract();
        lastContract.enabledPath = true;
        this.setLastContract(lastContract);
    }

    @api
    enableWarning()
    {
        let lastContract = this.getLastContract();
        lastContract.enabledWarning = true;
        this.setLastContract(lastContract);
    }

    @api
    usePagination()
    {
        let lastContract = this.getLastContract();
        lastContract.paginationAble = true;
        this.setLastContract(lastContract);
    }

    @api
    cloneContract(contract)
    {
        contract.response = undefined;
        contract.status = undefined;
        this.listContracts.push(contract);
    }
    
    @api
    getLastContract()
    {
        if(this.listContracts.length > 0)
        {
            let lastContract = this.listContracts[this.listContracts.length-1];

            if(lastContract.status != undefined && lastContract.status.includes('Completed'))
                this.listContracts.push({service: this.service, enabledPath: false, enabledWarning: false, paginationAble: false, mapPagination: {}});
            else
                return lastContract;
        }
        else
            this.listContracts.push({service: this.service, enabledPath: false, enabledWarning: false, paginationAble: false, mapPagination: {}});
        
        return this.listContracts[this.listContracts.length-1];
    }

    setLastContract(lastContract)
    {
        this.listContracts[this.listContracts.length-1] = lastContract;
    }

    @api
    callServiceMethod(
        serviceMethod,
        returnType,
        callBackFunction
    )
    {
        let lastContract = this.getLastContract();
        let requestBody = lastContract.params == undefined ? '' : JSON.stringify(lastContract.params);

        callServiceMethod({
            service: this.service,
            serviceMethod,
            bodyJson: requestBody,
            enabledPath: lastContract.enabledPath,
            enabledWarning: lastContract.enabledWarning,
            returnType,
            paginationAble: lastContract.paginationAble,
            mapPagination: lastContract.mapPagination,
        })
        .then(callBackFunction)
        .catch(error => {
            console.log(`Error CallService --> ${this.service} --> ${serviceMethod}`);
            console.log(error);
            this.showToast('Erro', 'Ocorreu um erro no backend, contate um administrador do sistema.', 'error');
        });
    }

    showToast(title, message, variant) 
    {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }
}