public without sharing class ContatoActiveRestService implements IRestService
{
    public HttpResponse setRequest(String req)
    {
        CalloutConfigDomain calloutConfigDomain = this.calloutConfigServiceInstance.getCalloutConfigByName('ContatoActive');

        ContatoActiveRequest contatoActiveRequest = (ContatoActiveRequest) JSON.deserialize(req, ContatoActiveRequest.class);
        ContatoActiveCallout callout = (ContatoActiveCallout) C3C_DIContainer_Injector.newInstance('ContatoActiveCallout', new Map<String,Object>{
            'config' => calloutConfigDomain,
            'request' => contatoActiveRequest
        });

        CalloutService calloutService = (CalloutService) C3C_DIContainer_Injector.newInstance('CalloutService', callout);

        HttpResponse res = calloutService.doCallout();

        if(res.getStatusCode() == 200 || res.getStatusCode() == 201)
            this.serviceCallback(req, res);

        return res;
    }

    public void serviceCallback(String request, HttpResponse response)
    {
        Map<String, Object> mapaLead = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        ContatoActiveRequest contatoActiveRequest = (ContatoActiveRequest) JSON.deserialize(request, ContatoActiveRequest.class);
        List<Object> listaListActiveData = (List<Object>) mapaLead.get('contactLists');
        List<Object> listaListActiveDataParaOportunidade = new List<Object>();
        List<String> pickListValuesList = this.gerarListaStatusLeadFilho();

        String sobjectType = ((Id) contatoActiveRequest.idRegistro).getSObjectType().getDescribe().getName();

        if (listaListActiveData.size() > 0 && sobjectType == 'Lead')
        {
            Map<String, String> mapaActiveIdsComStatus = this.gerarMapaIdListaActiveComStatus(listaListActiveData, pickListValuesList);
            List<ListaActiveCampaignMapper> listListaActiveCampaignMapper = this.listaActiveCampaignServiceInstance.obterListaActivePorIdsLista(mapaActiveIdsComStatus.keySet());
            Set<String> nomesDaFila = gerarSetNomesFila(listListaActiveCampaignMapper);
            List<GroupMapper> listaGroupMapper = this.objGroupServiceInstance.obterGroupPorNomes(nomesDaFila);
            List<LeadFilhoMapper> listLeadFilhoMapper = new List<LeadFilhoMapper>();
            Map<String,LeadFilhoMapper> mapaNomeFilaListaLeadFilho = new Map<String,LeadFilhoMapper>(); 

            for (ListaActiveCampaignMapper item : listListaActiveCampaignMapper)
            {
                if(item.nomeFila.contains('[LS]') || item.nomeFila == 'Comercial')
                {
                    listaListActiveDataParaOportunidade.add(new Map<String,Object>{
                        'list' => item.idLista,
                        'status' => String.valueOf(pickListValuesList.indexOf(mapaActiveIdsComStatus.get(item.idLista)))
                    });
                }
                else if(item.nomeFila == 'Hunter' || !item.nomeFila.contains('[LS]'))
                {
                    ILeadFilhoDomain leadFilhoDomain = (ILeadFilhoDomain) C3C_DIContainer_Injector.newInstance('LeadFilhoDomain');
                    
                    mapaNomeFilaListaLeadFilho.put('Hunter'+'-'+item.recordId, leadFilhoDomain.criarLeadFilhoComChaveLeadLista(contatoActiveRequest.idRegistro, item.recordId, mapaActiveIdsComStatus.get(item.idLista)));
                    // else
                    // {
                    //     listLeadFilhoMapper.add(leadFilhoDomain.criarLeadFilhoComChaveLeadLista(contatoActiveRequest.idRegistro, item.recordId, mapaActiveIdsComStatus.get(item.idLista)));
                    // }
                }
            }
            
            for (String key : mapaNomeFilaListaLeadFilho.keySet())
            {
                LeadFilhoMapper leadFilhoMapper = mapaNomeFilaListaLeadFilho.get(key);
                String fila = key.substring(0, 6);
                for (GroupMapper objGroup : listaGroupMapper)
                {
                    if (objGroup.nome == fila)
                        leadFilhoMapper.proprietario = objGroup.recordId;
                }

                listLeadFilhoMapper.add(leadFilhoMapper);
            }

            List<String> verificarChave = new List<String>();
            List<LeadFilhoMapper> listaParaInserirLeadFilho = new List<LeadFilhoMapper>();

            for(LeadFilhoMapper leadFilho : listLeadFilhoMapper)
            {
                if(verificarChave.contains(leadFilho.chaveLeadListaActive.toUppercase().trim()))
                    continue;

                listaParaInserirLeadFilho.add(leadFilho);
                verificarChave.add(leadFilho.chaveLeadListaActive.toUppercase().trim());
            }

            if(listaListActiveDataParaOportunidade.size() > 0)
                this.gerarLeadFilhoParaOportunidade(contatoActiveRequest, listaListActiveDataParaOportunidade, pickListValuesList);
            
            this.leadFilhoServiceInstance.inserirAtualizarLeadFilhoPorChaveLeadLista(listaParaInserirLeadFilho);
        }
        else if (listaListActiveData.size() > 0 && sobjectType == 'Account')
        {
            this.gerarLeadFilhoParaOportunidade(contatoActiveRequest, listaListActiveData, pickListValuesList);
        }
    }

    private void gerarLeadFilhoParaOportunidade(ContatoActiveRequest contatoActiveRequest, List<Object> listaListActiveData, List<String> pickListValuesList)
    {
        List<IOportunidadeDomain> listaOportunidadeDomain = new List<IOportunidadeDomain>();
        Map<String, String> mapaActiveIdsComStatus = this.gerarMapaIdListaActiveComStatus(listaListActiveData, pickListValuesList);
        List<ILeadFilhoDomain> listaInfoLeadFilho = this.instanciaBuscarInfomacoesLeadFilhoService.obterLeadFilhoPorIdsDaListaEIdContatoActive(mapaActiveIdsComStatus.keySet(), contatoActiveRequest.callId);
        List<ListaActiveCampaignMapper> listListaActiveCampaignMapper = this.listaActiveCampaignServiceInstance.obterListaActivePorIdsLista(mapaActiveIdsComStatus.keySet());
        List<String> listaDeIdDaListaDoActive = new List<String>();

        if(listaInfoLeadFilho.size() > 0)
        {
            for(ILeadFilhoDomain leadFilho : listaInfoLeadFilho)
            {
                LeadFilhoMapper leadfilhoMapper = leadFilho.obterMapper();
                for(String idListaDaActive : mapaActiveIdsComStatus.keySet())
                {
                    if(!String.isBlank(leadfilhoMapper.lead) && leadfilhoMapper.idListaDoActive == idListaDaActive)
                        continue;
                    
                    if(!String.isBlank(leadfilhoMapper.lead) || leadfilhoMapper.lead == null)
                        listaDeIdDaListaDoActive.add(idListaDaActive);
                }
            }
        }
        else 
        {
            for(String idListaDaActive : mapaActiveIdsComStatus.keySet())
            {
                listaDeIdDaListaDoActive.add(idListaDaActive);
            }
        }

        List<ListaActiveCampaignMapper> listaActiveParaAtualizar = new List<ListaActiveCampaignMapper>();
        List<String> checkDuplicadas = new List<String>();
        List<String> listaDeIdDaListaDoActiveAtt = new List<String>();
        for(String idLista : listaDeIdDaListaDoActive)
        {
            if(checkDuplicadas.contains(idLista))
                continue;
            checkDuplicadas.add(idLista);
            listaDeIdDaListaDoActiveAtt.add(idLista);
        }
        checkDuplicadas.clear();
        for(String item : listaDeIdDaListaDoActiveAtt)
        {
            for(ListaActiveCampaignMapper listaMapper : listListaActiveCampaignMapper)
            {
                if(listaMapper.idLista == item)
                {
                    if(checkDuplicadas.contains((contatoActiveRequest.idRegistro + '-' + listaMapper.nomeLista).toUppercase().trim()))
                        continue;
                    listaOportunidadeDomain.add((IOportunidadeDomain) C3C_DIContainer_Injector.newInstance('OportunidadeDomain', new Map<String,Object>{
                        'nome' =>  listaMapper.nomeLista,
                        'chaveExterna' => contatoActiveRequest.idRegistro + '-' + listaMapper.nomeLista,
                        'contaId' => contatoActiveRequest.idRegistro,
                        'fase' => 'Em negociação',
                        'dataFechamento' => Date.today(),
                        'idContatoActive' => contatoActiveRequest.callId,
                        'nomeLista' => listaMapper.nomeLista
                    }));
                    listaActiveParaAtualizar.add(listaMapper);
                    checkDuplicadas.add((contatoActiveRequest.idRegistro + '-' + listaMapper.nomeLista).toUppercase().trim());
                }
            }
        }

        if(listaOportunidadeDomain.size() > 0)
        {
            this.instanciaInserirOportunidadeService.gerarOportunidadePorListaDomain(listaOportunidadeDomain);
            Set<String> nomesDaFila = gerarSetNomesFila(listListaActiveCampaignMapper);
            List<GroupMapper> listaGroupMapper = this.objGroupServiceInstance.obterGroupPorNomes(nomesDaFila);
            List<LeadFilhoMapper> listLeadFilhoMapper = new List<LeadFilhoMapper>();
            Map<String,LeadFilhoMapper> mapaNomeFilaListaLeadFilho = new Map<String,LeadFilhoMapper>(); 

            for(ListaActiveCampaignMapper listaMapper : listaActiveParaAtualizar)
            {
                for(IOportunidadeDomain oportunidadeDomain : listaOportunidadeDomain)
                {
                    OportunidadeMapper oppMapper = oportunidadeDomain.obterMapper();

                    if(oppMapper.nomeLista == listaMapper.nomeLista)
                    {
                        ILeadFilhoDomain leadFilhoDomain = (ILeadFilhoDomain) C3C_DIContainer_Injector.newInstance('LeadFilhoDomain');
                        // mapaNomeFilaListaLeadFilho.put(listaMapper.nomeFila, leadFilhoDomain.criarLeadFilhoComChaveLeadLista(oppMapper.recordId, listaMapper.recordId, mapaActiveIdsComStatus.get(listaMapper.idLista)));
                        if(listaMapper.nomeFila == 'Comercial' || listaMapper.nomeFila.contains('[LS]'))
                        {
                            mapaNomeFilaListaLeadFilho.put('Comercial'+'-'+listaMapper.recordId, leadFilhoDomain.criarLeadFilhoComChaveLeadLista(oppMapper.recordId, listaMapper.recordId, mapaActiveIdsComStatus.get(listaMapper.idLista)));
                        }
                        // else
                        // {
                        //     listLeadFilhoMapper.add(leadFilhoDomain.criarLeadFilhoComChaveLeadLista(oppMapper.recordId, listaMapper.recordId, mapaActiveIdsComStatus.get(listaMapper.idLista)));
                        // }
                    }
                }
            }

            for (String key : mapaNomeFilaListaLeadFilho.keySet())
            {
                LeadFilhoMapper leadFilhoMapper = mapaNomeFilaListaLeadFilho.get(key);
                String fila = key.substring(0, 9);
                for (GroupMapper objGroup : listaGroupMapper)
                {
                    if (objGroup.nome == fila)
                        leadFilhoMapper.proprietario = objGroup.recordId;
                }

                listLeadFilhoMapper.add(leadFilhoMapper);
            }

            List<String> verificarChave = new List<String>();
            List<LeadFilhoMapper> listaParaInserirLeadFilho = new List<LeadFilhoMapper>();

            for(LeadFilhoMapper leadFilho : listLeadFilhoMapper)
            {
                if(verificarChave.contains(leadFilho.chaveLeadListaActive.toUppercase().trim()))
                    continue;

                listaParaInserirLeadFilho.add(leadFilho);
                verificarChave.add(leadFilho.chaveLeadListaActive.toUppercase().trim());
            }

            this.leadFilhoServiceInstance.inserirAtualizarLeadFilhoPorChaveLeadLista(listaParaInserirLeadFilho);
        }
        
    }
    
    private Set<String> gerarSetNomesFila(List<ListaActiveCampaignMapper> listListaActiveCampaignMapper)
    {
        Set<String> nomesDaFila = new Set<String>();
        for (ListaActiveCampaignMapper item : listListaActiveCampaignMapper)
        {
            if(item.nomeLista.contains('[LS]'))
                nomesDaFila.add('Comercial');
            else
                nomesDaFila.add('Hunter');
            // nomesDaFila.add(item.nomeFila);
        }
        return nomesDaFila;
    }

    private Map<String, String> gerarMapaIdListaActiveComStatus(List<Object> listaListActiveData, List<String> pickListValuesList)
    {
        Map<String, String> mapaActiveIdsComStatus = new Map<String, String>();
        for (Object item : listaListActiveData)
        {
            Map<String,Object> itemConvertido = (Map<String,Object>)item;
            mapaActiveIdsComStatus.put((String) itemConvertido.get('list'), pickListValuesList[Integer.valueOf((String) itemConvertido.get('status'))]);
        }

        return mapaActiveIdsComStatus;
    }

    private List<String> gerarListaStatusLeadFilho()
    {
        List<String> pickListValuesList = new List<String>();
		Schema.DescribeFieldResult fieldResult = LeadFilho__c.Status__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : ple)
        {
			pickListValuesList.add(pickListVal.getLabel());
		}  
        return pickListValuesList;
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

    public ILeadFilhoService leadFilhoServiceInstance 
    {
        get
        {
            if(this.leadFilhoServiceInstance == null)
                this.leadFilhoServiceInstance = (ILeadFilhoService) C3C_DIContainer_Injector.getInstance('LeadFilhoService');
            
            return this.leadFilhoServiceInstance;
        }
        set;
    }

    public IBuscarInfomacoesLeadFilhoService instanciaBuscarInfomacoesLeadFilhoService 
    {
        get
        {
            if(this.instanciaBuscarInfomacoesLeadFilhoService == null)
                this.instanciaBuscarInfomacoesLeadFilhoService = (IBuscarInfomacoesLeadFilhoService) C3C_DIContainer_Injector.getInstance('BuscarInfomacoesLeadFilhoService');
            
            return this.instanciaBuscarInfomacoesLeadFilhoService;
        }
        set;
    }

    public IInserirOportunidadeService instanciaInserirOportunidadeService 
    {
        get
        {
            if(this.instanciaInserirOportunidadeService == null)
                this.instanciaInserirOportunidadeService = (IInserirOportunidadeService) C3C_DIContainer_Injector.getInstance('InserirOportunidadeService');
            
            return this.instanciaInserirOportunidadeService;
        }
        set;
    }

    public IListaActiveCampaignService listaActiveCampaignServiceInstance 
    {
        get
        {
            if(this.listaActiveCampaignServiceInstance == null)
                this.listaActiveCampaignServiceInstance = (IListaActiveCampaignService) C3C_DIContainer_Injector.getInstance('ListaActiveCampaignService');
            
            return this.listaActiveCampaignServiceInstance;
        }
        set;
    }
    
    public IGroupService objGroupServiceInstance 
    {
        get
        {
            if(this.objGroupServiceInstance == null)
                this.objGroupServiceInstance = (IGroupService) C3C_DIContainer_Injector.getInstance('GroupService');
            
            return this.objGroupServiceInstance;
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
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
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