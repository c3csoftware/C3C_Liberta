public without sharing class AgendaDoUsuarioViewModel implements C3C_DI_IProvider 
{
    //Atributos
    @AuraEnabled 
    public String idUsuario {get;set;}  
    @AuraEnabled 
    public List<EventMapper> eventos {get;set;}

    //Construtores
    public AgendaDoUsuarioViewModel() 
    {}
    
    private AgendaDoUsuarioViewModel(String idUsuario, List<EventMapper> eventos)
    {
        System.debug(idUsuario);
        System.debug(eventos);
        this.construirAgendaDoUsuarioViewModel(idUsuario, eventos);
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapaParametro = (Map<String, Object>) params;
            return new AgendaDoUsuarioViewModel((String) mapaParametro.get('idUsuario'), (List<EventMapper>) mapaParametro.get('eventos'));
        }

        return null;
    }

    private void construirAgendaDoUsuarioViewModel(
        String idUsuario,
        List<EventMapper> eventos
    )
    {
        this.idUsuario = idUsuario;
        this.eventos = eventos;
    }
}