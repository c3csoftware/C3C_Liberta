public with sharing class EfetuarChamadaCTICallout extends CalloutContract implements C3C_DI_IProvider
{
    //Exception
    private EfetuarChamadaCTIRequest request {get; set;}

    //Construtores
    public EfetuarChamadaCTICallout()
    {
        super(null);
    }

    public EfetuarChamadaCTICallout(CalloutConfigDomain config, EfetuarChamadaCTIRequest request)
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

            return new EfetuarChamadaCTICallout(
                (CalloutConfigDomain) mapParams.get('config'), 
                (EfetuarChamadaCTIRequest) mapParams.get('request')
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

        if(this.request.origem != null)
            endPoint += '&Origem='+this.request.origem;

        if(this.request.callerId != null)
            endPoint += '&CallerID='+this.request.callerId;

        if(this.request.maximoTentativas != null)
            endPoint += '&MaximoTentativas='+this.request.maximoTentativas;
        
        if(this.request.intervaloEntreTentativas != null)
            endPoint += '&IntervaloEntreTentativas='+this.request.intervaloEntreTentativas;

        if(this.request.tempoEspera != null)
            endPoint += '&TempoEspera='+this.request.tempoEspera;
        
        if(this.request.centroDeCusto != null)
            endPoint += '&CentroDeCusto='+this.request.centroDeCusto;

        if(this.request.categoria != null)
            endPoint += '&Categoria='+this.request.categoria;
        
        if(this.request.destino != null)
            endPoint += '&Destino='+this.request.destino;

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