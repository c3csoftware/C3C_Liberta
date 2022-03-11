public without sharing class DesligarChamadaCTICallout extends CalloutContract implements C3C_DI_IProvider
{
    //Exception
    private DesligarChamadaCTIRequest request {get; set;}

    //Construtores
    public DesligarChamadaCTICallout()
    {
        super(null);
    }

    public DesligarChamadaCTICallout(CalloutConfigDomain config, DesligarChamadaCTIRequest request)
    {
        super(config);
        this.request = request;
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf Map<String, Object>)
        {
            Map<String,Object> mapParams = (Map<String,Object>) params;

            return new DesligarChamadaCTICallout(
                (CalloutConfigDomain) mapParams.get('config'), 
                (DesligarChamadaCTIRequest) mapParams.get('request')
            );
        }

        return null;
    }

    public override void setHeader(HttpRequest request)
    {
        request.setHeader('Content-Type', 'charset=utf-8');
    }

    //Construindo endPoint
    public override String getEndPoint()
    {
        String endPoint = this.configuration.endPoint;

        if(this.configuration.token != null)
            endPoint += '?pKey='+this.configuration.token;

        if(this.request.interfaceChamada != null)
            endPoint += '&Interface='+this.request.interfaceChamada;

        if(this.request.peer != null)
            endPoint += '&Peer='+this.request.peer;

        return endPoint;
    }

    public override String getBody()
    {
        return '';
    }

    public override Object getReturn(System.HTTPResponse response)
    {
        return response.getBody();
    }
}