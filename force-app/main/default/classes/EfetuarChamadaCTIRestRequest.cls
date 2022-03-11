public without sharing class EfetuarChamadaCTIRestRequest implements IRestService
{
    //Métodos

    //Método que vai fazera request
    public HttpResponse setRequest(String req)
    {
        //Buscando registro da configuração da callout
        CalloutConfigDomain calloutConfigDomain = this.calloutConfigServiceInstance.getCalloutConfigByName('L5CTI');

        //Criando instância da request EfetuarChamadaCTIResquest
        EfetuarChamadaCTIRequest efetuarChamadaCTIRequest = (EfetuarChamadaCTIRequest) JSON.deserialize(req, EfetuarChamadaCTIRequest.class);

        //Criando instância do contrato EfetuarChamadaCTICallout
        EfetuarChamadaCTICallout callout = (EfetuarChamadaCTICallout) C3C_DIContainer_Injector.newInstance('EfetuarChamadaCTICallout', new Map<String,Object>{
            'config' => calloutConfigDomain,
            'request' => efetuarChamadaCTIRequest
        });

        //Criando instância da callout service
        CalloutService calloutService = (CalloutService) C3C_DIContainer_Injector.newInstance('CalloutService', callout);

        //Executando a request
        HttpResponse res = calloutService.doCallout();

        //Encaminhando para callback
        this.serviceCallback(req, res);

        return res;
    }

    //Método callBack da requisição
    public void serviceCallback(String request, HttpResponse response)
    {
        EfetuarChamadaCTIRequest efetuarChamadaCTIRequest = (EfetuarChamadaCTIRequest) JSON.deserialize(request, EfetuarChamadaCTIRequest.class);
    }

    //Serviços
    public ICalloutConfigService calloutConfigServiceInstance 
    {
        get
        {
            if(this.calloutConfigServiceInstance == null)
                this.calloutConfigServiceInstance = (ICalloutConfigService) C3C_DIContainer_Injector.getInstance('CalloutConfigService');
            
            return this.calloutConfigServiceInstance;
        }
        set;
    }
}