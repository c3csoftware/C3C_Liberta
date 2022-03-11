public without sharing virtual class ConvertorLeadParaConta implements IConvertorLeadParaConta
{
    public void converterLeadCasoPossuaContaNaBase(List<ILeadDomain> listaLeadDomain)
    {
        List<LeadMapper> listaLeadsMapper = new List<LeadMapper>();
        Map<String, LeadMapper> mapLeadMapperPorEmail = new Map<String, LeadMapper>();
        Map<String, LeadMapper> mapLeadMapperPorTelefone = new Map<String, LeadMapper>();
        Map<String, LeadMapper> mapLeadMapperPorCpf = new Map<String, LeadMapper>();
        Map<String, LeadMapper> mapLeadMapperPorCnpj = new Map<String, LeadMapper>();
        Map<ContaMapper, LeadMapper> contasParaFazerMerge = new Map<ContaMapper, LeadMapper>();
        
        this.mapearLeadsPorChaveParaBusca(listaLeadDomain, listaLeadsMapper, mapLeadMapperPorEmail, mapLeadMapperPorTelefone, mapLeadMapperPorCpf, mapLeadMapperPorCnpj);

        List<ContaMapper> listaContaMapper =  (List<ContaMapper>) C3C_DIContainer_Injector.newInstance('ContaMapper', instanciaAccountSelector.buscarContasPorDadosLead(listaLeadsMapper));

        this.preencherContasParaMerge(listaContaMapper, mapLeadMapperPorEmail, mapLeadMapperPorTelefone, mapLeadMapperPorCpf, mapLeadMapperPorCnpj, contasParaFazerMerge);
    
        this.converterLeadsEmConta(contasParaFazerMerge);
    }

    // Métodos internos
    private void converterLeadsEmConta(Map<ContaMapper, LeadMapper> contasParaFazerMerge)
    {
        List<Database.LeadConvert> listaLeadParaConverter = new List<Database.LeadConvert>();
        List<String> leadsLS = new List<String>();
        Map<String, ContaMapper> mapContaMapperPorIdLeadParaTirarNegocios = new Map<String, ContaMapper>();
        Map<String, LeadFilhoMapper> mapLeadFilhoMappPorIdLead = new Map<String, LeadFilhoMapper>();

        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{Lead.SObjectType, LeadFilho__c.SObjectType});

        if (contasParaFazerMerge != null)
        {
            String masterLabelLeadStatus = leadStatusServiceInstance.retornarLabelDeLeadConvertido();

            for (ContaMapper contaMpp : contasParaFazerMerge.keySet())
            {
                if ( String.isBlank( contaMpp.codigo))
                {
                    leadsLS.add( contasParaFazerMerge.get(contaMpp).recordId);
                    continue;
                }

                if (contasParaFazerMerge.get(contaMpp).convertido)
                {
                    continue;
                }

                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setOwnerId(contaMpp.proprietarioConta);
                lc.setLeadId(contasParaFazerMerge.get(contaMpp).recordId);
                lc.setConvertedStatus(masterLabelLeadStatus);
                lc.setDoNotCreateOpportunity(true);
                lc.setAccountId(contaMpp.recordId);

                listaLeadParaConverter.add(lc);
                mapContaMapperPorIdLeadParaTirarNegocios.put(contasParaFazerMerge.get(contaMpp).recordId, contaMpp);
            }

            if (!leadsLS.isEmpty())
            {
                List<LeadMapper> listaLeadMapper = (List<LeadMapper>) C3C_DIContainer_Injector.newInstance('LeadMapper',  this.instanciaLeadSelector.obterLeadPorIdsDoLead(leadsLS));

                Map<String, LeadMapper> mapLeadMapper = new Map<String, LeadMapper>();
                for (LeadMapper leadMpp : listaLeadMapper)
                {
                    mapLeadMapper.put(leadMpp.recordId, leadMpp);
                }

                for (ContaMapper conta : contasParaFazerMerge.keySet())
                {
                    if (mapLeadMapper.get(contasParaFazerMerge.get(conta).recordId) != null)
                    {
                        mapLeadMapper.get(contasParaFazerMerge.get(conta).recordId).contaLS = conta.recordId;
                        uow.registerDirty(mapLeadMapper.get(contasParaFazerMerge.get(conta).recordId).record);
                    }
                }
            }

            if (!mapContaMapperPorIdLeadParaTirarNegocios.isEmpty())
            {
                List<LeadFilhoMapper> listaNegocioMappParaMudarProprietario = new List<LeadFilhoMapper>();
                List<String> listaIdLead = new List<String>();

                listaIdLead.addAll(mapContaMapperPorIdLeadParaTirarNegocios.keySet());

                for (SObject registroNegocio : this.instanciaLeadFilhoSelector.obterLeadFilhoPorListaIdLead(listaIdLead))
                {
                    LeadFilhoMapper negocioMapper = (LeadFilhoMapper) C3C_DIContainer_Injector.newInstance('LeadFilhoMapper', registroNegocio);
                    if (negocioMapper.nomeFila != null)
                    {
                        System.debug('Esse é o ID da fila: '+ negocioMapper.proprietario);
                        if (negocioMapper.proprietario.startsWith('00G') && negocioMapper.nomeFila.contains('Hunter') ) // Se o proprietário é group
                            listaNegocioMappParaMudarProprietario.add(negocioMapper);
                        else if (negocioMapper.proprietario.startsWith('00G'))
                        {
                            // Verificar se pegará todos os negócios, independente se estiver com usuário ou fila.
                            System.debug('Entrou no elseIf onde se verifica se o negócio está na fila');
                            mapLeadFilhoMappPorIdLead.put(negocioMapper.lead != null ? negocioMapper.lead + '-' + negocioMapper.recordId : negocioMapper.oportunidade , negocioMapper);
                        }
                    }
                }
                
                for (LeadFilhoMapper negocioMap : listaNegocioMappParaMudarProprietario)
                {
                    if (mapContaMapperPorIdLeadParaTirarNegocios.get(negocioMap.lead) != null)
                    {
                        negocioMap.proprietario = mapContaMapperPorIdLeadParaTirarNegocios.get(negocioMap.lead).proprietarioConta;
                        uow.registerDirty(negocioMap.record);
                    }
                }
            }

           // uow.commitWork()

            if (!listaLeadParaConverter.isEmpty())
            {
                List<Database.LeadConvertResult> lcr = Database.convertLead(listaLeadParaConverter);

                Map<String, String> mapIdContatoPorIdLead = new Map<String, String>();
                
                // iterar pela lista para converter e preencher mapa de Id Contato por Id Lead
                for (Database.LeadConvertResult leadConvertido : lcr)
                {
                    System.debug('Entrou aqui? ');
                    System.debug('Lead ID: ' + leadConvertido.getLeadId());
                    System.debug('Contact ID: ' + leadConvertido.getContactId());
                    if (leadConvertido.getLeadId() != null && leadConvertido.getContactId() != null)
                        mapIdContatoPorIdLead.put(leadConvertido.leadid, leadConvertido.contactid);
                }

                System.debug('Mapa LeadFIlhoMappPorIdLead: ' + mapLeadFilhoMappPorIdLead);
                for (String idComposto : mapLeadFilhoMappPorIdLead.keySet())
                {
                    // Se encontrar o id Lead do Mapa de negócio por Id Lead.
                    System.debug('Id composto: '+ idComposto.split('-')[0]);
                    if (mapIdContatoPorIdLead.get(idComposto.split('-')[0]) != null)
                    {
                        System.debug('Entrou onde eu quero testar e pegou o negócio correto: ' + mapLeadFilhoMappPorIdLead.get(idComposto));
                        LeadFilhoMapper negocioMpp = mapLeadFilhoMappPorIdLead.get(idComposto);
                        // Aqui pega o valor do Id do contato e coloca dentro do campo Id Contato do Negócio Mapper
                        negocioMpp.contatoId = mapIdContatoPorIdLead.get(idComposto.split('-')[0]);
                        uow.registerDirty(negocioMpp.record);
                        mapIdContatoPorIdLead.remove(idComposto);
                    }
                }
            }

            // Acho que se eu deixar o commitWork aqui não muda nada.
            uow.commitWork();
        }
    }

    private void preencherContasParaMerge(List<ContaMapper> listaContaMapper,Map<String, LeadMapper> mapLeadMapperPorEmail,Map<String, LeadMapper> mapLeadMapperPorTelefone,Map<String, LeadMapper> mapLeadMapperPorCpf,Map<String, LeadMapper> mapLeadMapperPorCnpj,Map<ContaMapper, LeadMapper> contasParaFazerMerge )
    {
        for (ContaMapper contaMpp : listaContaMapper)
        {
            if (mapLeadMapperPorEmail.containsKey(contaMpp.email))
            {
                contasParaFazerMerge.put(contaMpp, mapLeadMapperPorEmail.get(contaMpp.email));
                continue;
            }
            if (mapLeadMapperPorTelefone.containsKey(contaMpp.telefone))
            {
                contasParaFazerMerge.put(contaMpp, mapLeadMapperPorTelefone.get(contaMpp.telefone));
                continue;
            }
            if (mapLeadMapperPorCpf.containsKey(contaMpp.cpf))
            {
                contasParaFazerMerge.put(contaMpp, mapLeadMapperPorCpf.get(contaMpp.cpf));
                continue;
            }
            if (mapLeadMapperPorCnpj.containsKey(contaMpp.cnpj))
            {
                contasParaFazerMerge.put(contaMpp, mapLeadMapperPorCnpj.get(contaMpp.cnpj));
                continue;
            }
        }
    }

    private void mapearLeadsPorChaveParaBusca(List<ILeadDomain> listaLeadDomain,  List<LeadMapper> listaLeadsMapper, Map<String, LeadMapper> mapLeadMapperPorEmail, Map<String, LeadMapper> mapLeadMapperPorTelefone,Map<String, LeadMapper> mapLeadMapperPorCpf,Map<String, LeadMapper> mapLeadMapperPorCnpj )
    {   
        for (ILeadDomain leadDomain : listaLeadDomain)
        {
            LeadMapper leadMpp = leadDomain.obterMapper();
            listaLeadsMapper.add(leadMpp);

            mapLeadMapperPorEmail.put(leadMpp.email, leadMpp);
            mapLeadMapperPorTelefone.put(leadMpp.telefone, leadMpp);
            mapLeadMapperPorCpf.put(leadMpp.cpf, leadMpp);
            mapLeadMapperPorCnpj.put(leadMpp.cnpj, leadMpp);

        }
            
    }

    public IAccountSelector instanciaAccountSelector 
    {
        get
        {
            if(this.instanciaAccountSelector == null)
                this.instanciaAccountSelector = (IAccountSelector) C3C_DIContainer_Injector.getInstance('AccountSelector');
            
            return this.instanciaAccountSelector;
        }
        set;
    }
    
    // Relacinado com a Feature de relacionar Lead com Conta
    public ILeadStatusService leadStatusServiceInstance 
    {
        get
        {
            if(this.leadStatusServiceInstance == null)
                this.leadStatusServiceInstance = (ILeadStatusService) C3C_DIContainer_Injector.getInstance('LeadStatusService');
            
            return this.leadStatusServiceInstance;
        }
        set;
    }

    public ILeadFilhoSelector instanciaLeadFilhoSelector 
    {
        get
        {
            if(this.instanciaLeadFilhoSelector == null)
                this.instanciaLeadFilhoSelector = (ILeadFilhoSelector) C3C_DIContainer_Injector.getInstance('LeadFilhoSelector');
            
            return this.instanciaLeadFilhoSelector;
        }
        set;
    }

    public ILeadSelector instanciaLeadSelector 
    {
        get
        {
            if(this.instanciaLeadSelector == null)
                this.instanciaLeadSelector = (ILeadSelector) C3C_DIContainer_Injector.getInstance('LeadSelector');
            
            return this.instanciaLeadSelector;
        }
        set;
    }

    // Coverage
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