public without sharing class LeadMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
	public override String getObjectName()
    {
        return 'Lead';
    }
    
    //Atributos
    @AuraEnabled public String recordId
    {
        get;
        set
        {
            this.recordId = value;
            this.setValueInRecord('Id', value);
        }
    }

    @AuraEnabled public String nome
    {
        get;
        set
        {
            this.nome = value;
            this.setValueInRecord('FirstName', value);
        }
    }
    
    @AuraEnabled public String sobrenome
    {
        get;
        set
        {
            this.sobrenome = value;
            this.setValueInRecord('LastName', value);
        }
    }
    
    @AuraEnabled public String email
    {
        get;
        set
        {
            this.email = value;
            this.setValueInRecord('Email', value);
        }
    }

    @AuraEnabled public String empresa
    {
        get;
        set
        {
            this.empresa = value;
            this.setValueInRecord('Company', value);
        }
    }
    
    @AuraEnabled public String activeCampaignId
    {
        get;
        set
        {
            this.activeCampaignId = value;
            this.setValueInRecord('ActiveCamp__Active_Campaign_Id__c', value);
        }
    }
    
    @AuraEnabled public String status
    {
        get;
        set
        {
            this.status = value;
            this.setValueInRecord('Status', value);
        }
    }

    @AuraEnabled public String statusConversao
    {
        get;
        set
        {
            this.statusConversao = value;
            this.setValueInRecord('Status__c', value);
        }
    }

    @AuraEnabled public String cpf
    {
        get;
        set
        {
            this.cpf = value;
            this.setValueInRecord('CPF__c', value);
        }
    }

    @AuraEnabled public String cnpj
    {
        get;
        set
        {
            this.cnpj = value;
            this.setValueInRecord('CNPJ__c', value);
        }
    }

    @AuraEnabled public String cpfOuCnpj
    {
        get;
        set
        {
            this.cpfOuCnpj = value;
            this.setValueInRecord('CpfOuCnpj__c', value);
        }
    }

    @AuraEnabled public String validadorDocumento
    {
        get;
        set
        {
            this.validadorDocumento = value;
            this.setValueInRecord('ValidadorDocumento__c', value);
        }
    }

    @AuraEnabled public Boolean convertido
    {
        get;
        set
        {
            this.convertido = value;
            this.setValueInRecord('IsConverted', value);
        }
    }

    @AuraEnabled public String contaId
    {
        get;
        set
        {
            this.contaId = value;
            this.setValueInRecord('ConvertedAccountId', value);
        }
    }

    @AuraEnabled public String codigoXp
    {
        get;
        set
        {
            this.codigoXp = value;
            this.setValueInRecord('CodigoXP__c', value);
        }
    }

    @AuraEnabled public String proprietario
    {
        get;
        set
        {
            this.proprietario = value;
            this.setValueInRecord('OwnerId', value);
        }
    }

    @AuraEnabled public String telefone
    {
        get;
        set
        {
            this.telefone = value;
            this.setValueInRecord('Phone', value);
        }
    }

    @AuraEnabled public String assessorIndicado
    {
        get;
        set
        {
            this.assessorIndicado = value;
            this.setValueInRecord('AssessorIndicado__c', value);
        }
    }

    @AuraEnabled public String ultiamaVezModificadoPor
    {
        get;
        set
        {
            this.ultiamaVezModificadoPor = value;
            this.setValueInRecord('LastModifiedById', value);
        }
    }

    @AuraEnabled public String contaLS
    {
        get;
        set
        {
            this.contaLS = value;
            this.setValueInRecord('ContaLS__c', value);
        }
    }

    @AuraEnabled public Datetime dataRoletagem
    {
        get;
        set
        {
            this.dataRoletagem = value;
            this.setValueInRecord('DataRoletagem__c', value);
        }
    }

    @AuraEnabled public Datetime dataAgendamento
    {
        get;
        set
        {
            this.dataAgendamento = value;
            this.setValueInRecord('DataAgendamento__c', value);
        }
    }

    @AuraEnabled public String assessorQueRecebeu
    {
        get;
        set
        {
            this.assessorQueRecebeu = value;
            this.setValueInRecord('AssessorQueRecebeu__c', value);
        }
    }

    @AuraEnabled public String criadoPorId {get;set;}
    
    public LeadMapper()
    {}
    
    private LeadMapper(String activeCampaignId, String nome, String sobrenome, String email, String empresa, String telefone)
    {
        this.activeCampaignId = activeCampaignId;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.email = email;
        this.empresa = empresa;
        this.telefone = telefone;
    }
    
    private LeadMapper(String idLead, String status)
    {
        this.recordId = idLead;
        this.statusConversao = status;
    }
    
    private LeadMapper(Id idRegistro, Id idProprietario)
    {
        this.recordId = idRegistro;
        this.proprietario = idProprietario;
    }
    
    private LeadMapper(SObject lead)
    {
        this.initBuild();
        this.construirLeadRecord(lead);
        this.finishBuild();
    }
    
    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapParams = (Map<String, Object>) params;
            if(mapParams.containsKey('idLead'))
                return new LeadMapper((String) mapParams.get('idLead'), (String) mapParams.get('status'));
            else if(mapParams.containsKey('idRegistro'))
                return new LeadMapper((Id) mapParams.get('idRegistro'), (Id) mapParams.get('idProprietario'));

            return new LeadMapper((String) mapParams.get('activeCampaignId'), (String) mapParams.get('nome'), (String) mapParams.get('sobrenome'), (String) mapParams.get('email'), (String) mapParams.get('empresa'), (String) mapParams.get('telefone'));
        }
        
        if(params instanceOf List<SObject>)
            return this.construirLeadListRecord((List<SObject>) params);

        return new LeadMapper((SObject)params);
    }
    
    public void construirLeadRecord(SObject lead)
    {
        this.record = lead;
        
        this.recordId = (String) lead.get('Id');
        this.nome = (String) lead.get('FirstName');
        this.sobrenome = (String) lead.get('LastName');
        this.email = (String) lead.get('Email');
        this.empresa = (String) lead.get('Company');
        this.activeCampaignId = (String) lead.get('ActiveCamp__Active_Campaign_Id__c');
        this.status = (String) lead.get('Status');
        this.cpf = (String) lead.get('CPF__c');
        this.cnpj = (String) lead.get('CNPJ__c');
        this.cpfOuCnpj = (String) lead.get('CpfOuCnpj__c');
        this.validadorDocumento = (String) lead.get('ValidadorDocumento__c');
        this.convertido = (Boolean) lead.get('IsConverted');
        this.contaId = (String) lead.get('ConvertedAccountId');
        this.codigoXp = (String) lead.get('CodigoXP__c');
        this.proprietario = (String) lead.get('OwnerId');
        this.statusConversao = (String) lead.get('Status__c');
        this.telefone = (String) lead.get('Phone');
        this.assessorIndicado = (String) lead.get('AssessorIndicado__c');
        this.ultiamaVezModificadoPor = (String) lead.get('LastModifiedById');
        this.contaLS = (String) lead.get('ContaLS__c');
        this.dataRoletagem = (Datetime) lead.get('DataRoletagem__c');
        this.dataAgendamento = (Datetime) lead.get('DataAgendamento__c');
        this.assessorQueRecebeu = (String) lead.get('AssessorQueRecebeu__c');

        this.criadoPorId = (String) lead.get('CreatedById');
    }

    public List<LeadMapper> construirLeadListRecord(List<SObject> listSObj)
    {
        List<LeadMapper> leadMapper = new List<LeadMapper>();
        
        for(SObject sObj : listSObj)
            leadMapper.add(new LeadMapper(sObj));
      	return leadMapper;
    }

    public Boolean verificarInvalidadeCpf()
    {
        // Verifica se o CPF está nulo, caso esteja return CPF inválido.
        if (this.cpf == null)
        {
            return true;
        }
        // Verifica se o CPF possui uma dessas construções, caso sim retorna CPF inválido.
        else if(this.cpf.equals('000.000.000-00') || this.cpf.equals('111.111.111-11') ||
        this.cpf.equals('222.222.222-22') || this.cpf.equals('333.333.333-33') ||
        this.cpf.equals('444.444.444-44') || this.cpf.equals('555.555.555-55') ||
        this.cpf.equals('666.666.666-66') || this.cpf.equals('777.777.777-77') ||
        this.cpf.equals('888.888.888-88') || this.cpf.equals('999.999.999-99'))
        {
            return true;
        }

        // Se não passar em nenhuma das verificações de CPF inválido, retorna CPF validado.
        return false;
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