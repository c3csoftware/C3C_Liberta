public without sharing virtual class LeadAssessorService implements ILeadAssessorService
{
    //
    //Métodos
    //

    //Responsável por criar uma tarefa de "Conversão de Lead" caso o lead for criado por um usuário Assessor Liberta
    public void criarTarefaConversaoLeadQuandoCriadoPerfilAssessorLiberta(List<ILeadDomain> listaLead)
    {
        List<String> listaIdUsuarioCriaramLead = new List<String>();
        Map<String, UserMapper> mapaUsuarioPorId = new Map<String, UserMapper>();
        List<Map<String, Object>> listaLeadParaCriarTarefaConversaoLead = new List<Map<String, Object>>();

        for(ILeadDomain lead : listaLead)
        {
            LeadMapper leadMapper = lead.obterMapper();

            listaIdUsuarioCriaramLead.add(leadMapper.criadoPorId);
        }

        for(UserDomain usuario : this.instanciaUsuarioPerfilService.obterListaUsuarioPeloIdComNomePerfil(listaIdUsuarioCriaramLead))
        {
            UserMapper usuarioMapper = usuario.obterMapper();

            mapaUsuarioPorId.put(usuarioMapper.idRegistro, usuarioMapper);
        }

        for(ILeadDomain lead : listaLead)
        {
            LeadMapper leadMapper = lead.obterMapper();

            if(mapaUsuarioPorId.containsKey(leadMapper.criadoPorId))
                continue;

            UserMapper usuarioMapper = mapaUsuarioPorId.get(leadMapper.criadoPorId);
            
            if(usuarioMapper.nomePerfil == 'Assessor Liberta')
            {
                listaLeadParaCriarTarefaConversaoLead.add(new Map<String, Object>{
                    'idResponsavelTarefa' => leadMapper.criadoPorId,
                    'idLead' => leadMapper.recordId
                });
            }
        }

        this.instanciaTarefaConversaoLeadService.criarListaTarefasConversaoLead(listaLeadParaCriarTarefaConversaoLead);
    }

    //
    //Atributos de serviços
    //

    private IUsuarioPerfilService instanciaUsuarioPerfilService 
    {
        get
        {
            if(this.instanciaUsuarioPerfilService == null)
                this.instanciaUsuarioPerfilService = (IUsuarioPerfilService) C3C_DIContainer_Injector.getInstance('UsuarioPerfilService');
            
            return this.instanciaUsuarioPerfilService;
        }
        set;
    }

    private ITarefaConversaoLeadService instanciaTarefaConversaoLeadService
    {
        get
        {
            if(this.instanciaTarefaConversaoLeadService == null)
                this.instanciaTarefaConversaoLeadService = (ITarefaConversaoLeadService) C3C_DIContainer_Injector.getInstance('TarefaConversaoLeadService');
            
            return this.instanciaTarefaConversaoLeadService;
        }
        set;
    }
}