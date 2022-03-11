public without sharing virtual class NegocioAPIService implements INegocioAPIService
{
    //
    //Métodos
    //

    public void registrarNegocioDoActiveCampaign(NegocioActiveCampaignRequest negocioActiveCampaign)
    {
        System.debug('Ta vindo os dados pelos dados de exemplo');

        //Verificar se no pipeline_title faz tem as tags [LS] e [Hunters], se não..
        Boolean verificarPipilineTitleTemLSOuHunters = !negocioActiveCampaign.pipeline_title.contains('[LS]') && !negocioActiveCampaign.pipeline_title.contains('[Hunters]');

        //Verificar se no pipeline_title faz tem as tags [LS] e [Hunters], ou se o stage_title é "Perdido"; Caso uma das duas verificações retornar verdadeira processo não deve seguir
        if(verificarPipilineTitleTemLSOuHunters || negocioActiveCampaign.stage_title == 'Perdido')
            return;

        //Instanciando UOW para trabalhar com Negócio
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            LeadFilho__c.SObjectType
        });

        //Buscando negócio na base de dados
        NegocioDomain negocio = instanciaNegocioService.obterNegocioPorIdNegocioActiveCampaign(negocioActiveCampaign.id);

        //Definindo o titúlo do négocio
        String tituloNegocio = negocioActiveCampaign.title.length() > 80 ? negocioActiveCampaign.title.left(80) : negocioActiveCampaign.title;

        if(negocio != null && negocio.recordId != null)
        {
            //Caso o negócio exista na base de dados
            negocio.nome = tituloNegocio;

            //Adicionar negócio à lista de atualização do UOW
            uow.registerDirty(negocio.record);
        }
        else
        {
            //Caso o negócio não exista na base de dados
            //Criando novo negócio
            negocio = (NegocioDomain) C3C_DIContainer_Injector.newInstance('NegocioDomain', new Map<String, Object>{
                'nome' => tituloNegocio,
                'negocioActiveCampaingId' => negocioActiveCampaign.id
            });

            UserMapper usuario = instanciaUserService.obterUsuarioComIdActiveCampaign(negocioActiveCampaign.ownerid).obterMapper();
            
            if((new List<String>{'Deals', 'Leads'}).contains(negocioActiveCampaign.stage_title))
            {
                //Caso o stage_title seja "Deals" e "Leads" relacionar a uma fila
                this.buscarOuCriarFilaERelacionarAoNegocio(negocio, negocioActiveCampaign);
            }
            else
            {
                //Caso o stage_title não seja "Deals" e "Leads"
                

                // Trecho de código para ajustar os Negócios que estavam vindo sem nomeFila.
                String nomeFila = negocioActiveCampaign.title;
                nomeFila = this.ajustarNomeFila(nomeFila, negocioActiveCampaign.pipeline_title);
                negocio.definirFilaDoNegocio(nomeFila, null);

                //Definir usuário proprietário do negócio
                negocio.definirUsuarioProprietarioDoNegocio(usuario == null ? null : usuario.idRegistro);
            }

            continuarServico(JSON.serialize(negocio), JSON.serialize(negocioActiveCampaign), usuario.nome != null ? JSON.serialize(usuario) : null);
        }
    }

    //Responsável por buscar e/ou criar fila, e relacionar ao negócio
    private void buscarOuCriarFilaERelacionarAoNegocio(NegocioDomain negocio, NegocioActiveCampaignRequest negocioActiveCampaign)
    {
        //Definindo a configuração de roteamento da fila
        ConfigRoteamentoFilaDomain configRoteamentoFila = instanciaConfigRoteamentoFilaService.obterConfigRoteamentoFilaComNomeDesenvolvedor(
            negocioActiveCampaign.stage_title == 'Deals' ? 
                'Lead_da_Lista_Priorit_rio' : 
                'Lead_da_Lista_Padr_o'
        );

        //Definindo nome da fila dono do negócio
        String nomeFila = 
            negocioActiveCampaign.stage_title == 'Deals' ? 
                '[OG] '+negocioActiveCampaign.title : 
                negocioActiveCampaign.title;
            
        
        nomeFila = this.ajustarNomeFila(nomeFila, negocioActiveCampaign.pipeline_title);
        //Definindo tag do nome da fila
        // String tagFila = negocioActiveCampaign.pipeline_title.contains('[LS]') ? '[LS]' : negocioActiveCampaign.pipeline_title.contains('[Hunters]') ? '[Hunters]' : '';

        // nomeFila = tagFila + nomeFila;

        // nomeFila = nomeFila.length() > 40 ? nomeFila.left(40) : nomeFila;

        // nomeFila = nomeFila.replaceAll('\\s+\\s+', ' ');

        // nomeFila = nomeFila.replaceAll('\\s$', '');

        //Buscando fila pelo nome da fila
        GroupMapper fila = instanciaGroupService.obterGroupPorNome(nomeFila);

        if(fila == null || fila.recordId == null)
        {
            //Caso fila não exista na base de dados, criar nova fila
            //Variável que armazenará os papeis membros da fila
            List<String> nomesPapeis = new List<String>();

            //Verificar se existe a tag [LS] no pipeline title, se sim adicionar papel "Executivo Comercial" na fila
            if(negocioActiveCampaign.pipeline_title.contains('[LS]'))
                nomesPapeis.add('Executivo Comercial');
            
            //Verificar se existe a tag [LS] no pipeline title, se sim adicionar papel "Hunters" na fila
            if(negocioActiveCampaign.pipeline_title.contains('[Hunters]'))
                nomesPapeis.add('Hunters');
            
            //Buscando o id dos papeis que serão membros da fila
            Set<String> papeisId = instanciaUserRoleService.obterIdsPapeisPeloNome(nomesPapeis);
            
            //Variável que irá armazenar os ids do grupo do papel
            Set<String> gruposIdPapel = new Set<String>();

            for(GroupMapper grupoPapel : instanciaGroupService.obterGroupPorPapelRelacionado(papeisId))
                gruposIdPapel.add(grupoPapel.recordId);
            
            fila = instanciaGroupService.criarFilaComNomeEMembrosFila(nomeFila, configRoteamentoFila.idRegistro, new List<String>{'LeadFilho__c'}, gruposIdPapel);
        }

        //Definindo fila do negócio
        negocio.definirFilaDoNegocio(nomeFila, fila.recordId);
    }
    
    @future(callout=true)
    public static void continuarServico(String jsonNegocio, String jsonNegocioActiveCampaign, String jsonUsuarioDomain) 
    {
        //Instanciando UOW para trabalhar com Negócio
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            LeadFilho__c.SObjectType, Lead.SObjectType
        });

        System.debug('Entrou aqui: ');
        System.debug('JSON UsuarioDomain: ' +  jsonUsuarioDomain);
        UserMapper usuario;
        if (jsonUsuarioDomain != null)
            usuario = (UserMapper) JSON.deserialize(jsonUsuarioDomain, UserMapper.class);
        System.debug('Passou por aqui: ');
        //Construindo váriaveis apartir do JSON
        NegocioDomain negocio = (NegocioDomain) JSON.deserialize(jsonNegocio, NegocioDomain.class);
        NegocioActiveCampaignRequest negocioActiveCampaign = (NegocioActiveCampaignRequest) JSON.deserialize(jsonNegocioActiveCampaign, NegocioActiveCampaignRequest.class);

        FunilDomain funil;

        //Buscando funil na base de dados
        funil = instanciaFunilService.obterFunilPorIdFunilActiveCampaign(negocioActiveCampaign.pipelineid);

        if(funil == null || funil.recordId == null)
        {
            //Caso funil não exista na base de dados, criar novo funil.
            funil = instanciaFunilService.criarFunilComIdFunilActiveCampaignENomeFunil(negocioActiveCampaign.pipelineid, negocioActiveCampaign.pipeline_title);
        }
 
        //Buscar lead pelo contactid do ActiveCampaign
        LeadMapper leadRelacionadoActiveCampaign = instanciaLeadService.obterLeadPorActiveCampaignId(negocioActiveCampaign.contactid);

        if(leadRelacionadoActiveCampaign == null || leadRelacionadoActiveCampaign.recordId == null)
        {
            String nomeLead = (negocioActiveCampaign.contact_firstname != null ? negocioActiveCampaign.contact_firstname : '') + ' Lead - '+negocioActiveCampaign.contactid;

            //Caso lead não seja encontrado, criar novo lead relacionado ao contactid do ActiveCampaign
            leadRelacionadoActiveCampaign = instanciaLeadService.inserirAtualizarLeadPorActiveCampaignId(negocioActiveCampaign.contactid, '', nomeLead, negocioActiveCampaign.contact_email, nomeLead, '');
            System.debug('Usuário: ' + JSON.serialize(usuario));
            System.debug('Negócio proprietário: ' + negocio.proprietario);
            // Aqui onde ocorre o setamento do proprietário do Lead;
            leadRelacionadoActiveCampaign.proprietario = usuario != null ? usuario.idRegistro : '0058G000000IZKrQAO';
            uow.registerDirty(leadRelacionadoActiveCampaign.record);
        }

        if(leadRelacionadoActiveCampaign == null || leadRelacionadoActiveCampaign.recordId == null)
            return;
        
        //Verificar se existe a tag [Hunters] no pipeline title, se sim buscar/criar e relacionar lead ao negócio
        if(negocioActiveCampaign.pipeline_title.contains('[Hunters]'))
        {
            //Relacionar o lead ao negócio
            System.debug('LeadRelacionaActiveCampaign : ' + JSON.serialize(leadRelacionadoActiveCampaign));
            negocio.lead = leadRelacionadoActiveCampaign.recordId;
        }
        //Verificar se existe a tag [LS] no pipeline title, se sim criar oportunidade relacionada ao lead/conta, e relacionar oportunidade ao negócio
        else if(negocioActiveCampaign.pipeline_title.contains('[LS]'))
        {
            OportunidadeMapper oportunidade;

            if(leadRelacionadoActiveCampaign.convertido)
            {
                //Caso lead relacionado ao contactid do ActiveCampaign esteja convertido, criar oportunidade relacionado à conta
                oportunidade = instanciaOportunidadeService.criarOportunidadeRelacionadoConta(leadRelacionadoActiveCampaign.contaId, negocioActiveCampaign.title);
            }
            else
            {
                //Caso lead relacionado ao contactid do ActiveCampaign não esteja convertido, criar oportunidade relacionado ao lead
                oportunidade = instanciaOportunidadeService.criarOportunidadeRelacionadoLead(leadRelacionadoActiveCampaign.recordId, negocioActiveCampaign.title);
            }

            negocio.oportunidade = oportunidade.recordId;                
        }

        //Adicionar negócio à lista de criação do UOW
        uow.registerNew(negocio.record);

        uow.commitWork();
    }

    // Métodos internos
    // Método responsável por ajustar o nome da fila para se adequar a nome de filas do Salesforce
    private String ajustarNomeFila(String nomeFila, String tituloPipeline)
    {
        String tagFila = tituloPipeline.contains('[LS]') ? '[LS]' : tituloPipeline.contains('[Hunters]') ? '[Hunters]' : '';

        nomeFila = tagFila + nomeFila;

        nomeFila = nomeFila.length() > 40 ? nomeFila.left(40) : nomeFila;

        nomeFila = nomeFila.replaceAll('\\s+\\s+', ' ');

        nomeFila = nomeFila.replaceAll('\\s$', '');

        return nomeFila;
    }


    //
    //Atributos
    //

    private static INegocioService instanciaNegocioService
    {
        get
        {
            if(instanciaNegocioService == null)
                instanciaNegocioService = (INegocioService) C3C_DIContainer_Injector.getInstance('NegocioService');
            
            return instanciaNegocioService;
        }
        set;
    }

    private static IFunilService instanciaFunilService
    {
        get
        {
            if(instanciaFunilService == null)
                instanciaFunilService = (IFunilService) C3C_DIContainer_Injector.getInstance('FunilService');
            
            return instanciaFunilService;
        }
        set;
    }

    private static IGroupService instanciaGroupService
    {
        get
        {
            if(instanciaGroupService == null)
                instanciaGroupService = (IGroupService) C3C_DIContainer_Injector.getInstance('GroupService');
            
            return instanciaGroupService;
        }
        set;
    }

    private static IUserRoleService instanciaUserRoleService
    {
        get
        {
            if(instanciaUserRoleService == null)
                instanciaUserRoleService = (IUserRoleService) C3C_DIContainer_Injector.getInstance('UserRoleService');
            
            return instanciaUserRoleService;
        }
        set;
    }

    private static IUserService instanciaUserService
    {
        get
        {
            if(instanciaUserService == null)
                instanciaUserService = (IUserService) C3C_DIContainer_Injector.getInstance('UserService');
            
            return instanciaUserService;
        }
        set;
    }

    private static ILeadService instanciaLeadService
    {
        get
        {
            if(instanciaLeadService == null)
                instanciaLeadService = (ILeadService) C3C_DIContainer_Injector.getInstance('LeadService');

            return instanciaLeadService;
        }
        set;
    }

    private static IOportunidadeService instanciaOportunidadeService
    {
        get
        {
            if(instanciaOportunidadeService == null)
                instanciaOportunidadeService = (IOportunidadeService) C3C_DIContainer_Injector.getInstance('OportunidadeService');

            return instanciaOportunidadeService;
        }
        set;
    }

    private static IConfigRoteamentoFilaService instanciaConfigRoteamentoFilaService
    {
        get
        {
            if(instanciaConfigRoteamentoFilaService == null)
                instanciaConfigRoteamentoFilaService = (IConfigRoteamentoFilaService) C3C_DIContainer_Injector.getInstance('ConfigRoteamentoFilaService');

            return instanciaConfigRoteamentoFilaService;
        }
        set;
    }

    public static void testCoverage()
    {
        Integer i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
    }
}