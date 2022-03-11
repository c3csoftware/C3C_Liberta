public without sharing class DesligarChamadaCTIRequest implements C3C_DI_IProvider
{
    //Exception
    public class DesligarChamadaCTIRequestException extends Exception {}

    //Atributos
    public String interfaceChamada {get; set;}
    public String peer {get; set;}

    //Construtores
    public DesligarChamadaCTIRequest(){}

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf Map<String, Object>)
            return (DesligarChamadaCTIRequest) JSON.deserialize(JSON.serialize((Map<String,Object>) params), DesligarChamadaCTIRequest.class);

        return null;
    }
}