public without sharing class EfetuarChamadaCTIRequest implements C3C_DI_IProvider
{
    //Exception
    public class EfetuarChamadaCTIRequestException extends Exception {}

    //Atributos
    public String interfaceChamada {get; set;}
    public String origem {get; set;}
    public String callerId {get; set;}
    public Integer maximoTentativas {get; set;}
    public Integer intervaloEntreTentativas {get; set;}
    public Integer tempoEspera {get; set;}
    public String centroDeCusto {get; set;}
    public String categoria {get; set;}
    public String destino {get; set;}

    //Construtores
    public EfetuarChamadaCTIRequest(){}

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf Map<String, Object>)
            return (EfetuarChamadaCTIRequest) JSON.deserialize(JSON.serialize((Map<String,Object>) params), EfetuarChamadaCTIRequest.class);

        return null;
    }
}