public with sharing class DesligarChamadaCTIRestRequest implements IRestService
{
    //Métodos

    //Método que vai fazer a request
    public HttpResponse setRequest(String req)
    {
        //Buscando registro da configuração da callout
        CalloutConfigDomain calloutConfigDomain = this.calloutConfigServiceInstance.getCalloutConfigByName('L5CTI');

        //Criando instância da request DesligarChamadaCTIRequest
        DesligarChamadaCTIRequest desligarChamadaCTIRequest = (DesligarChamadaCTIRequest) JSON.deserialize(req, DesligarChamadaCTIRequest.class);

        //Criando instância do contrato DesligarChamadaCTICallout
        DesligarChamadaCTICallout callout = (DesligarChamadaCTICallout) C3C_DIContainer_Injector.newInstance('DesligarChamadaCTICallout', new Map<String,Object>{
            'config' => calloutConfigDomain,
            'request' => DesligarChamadaCTIRequest
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
        DesligarChamadaCTIRequest DesligarChamadaCTIRequest = (DesligarChamadaCTIRequest) JSON.deserialize(request, DesligarChamadaCTIRequest.class);
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