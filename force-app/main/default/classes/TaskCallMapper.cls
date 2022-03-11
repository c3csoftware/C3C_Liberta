public without sharing class TaskCallMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    //Responsável por definir o SObject
    public override String getObjectName()
    {
        return 'Task';
    }

    //
    //Atributos
    //

    @AuraEnabled public String idRegistro
    {
        get;
        set
        {
            this.idRegistro = value;
            this.setValueInRecord('Id', value);
        }
    }

    @AuraEnabled public String assunto
    {
        get;
        set
        {
            this.assunto = value;
            this.setValueInRecord('Subject', value);
        }
    }

    @AuraEnabled public String prioridade
    {
        get;
        set
        {
            this.prioridade = value;
            this.setValueInRecord('Priority', value);
        }
    }

    @AuraEnabled public String referenciaChamada
    {
        get;
        set
        {
            this.referenciaChamada = value;
            this.setValueInRecord('CallObject', value);
        }
    }
    
    @AuraEnabled public String tipoChamada
    {
        get;
        set
        {
            this.tipoChamada = value;
            this.setValueInRecord('CallType', value);
        }
    }

    @AuraEnabled public String tipo
    {
        get;
        set
        {
            this.tipo = value;
            this.setValueInRecord('Type', value);
        }
    }

    private String subTipoTarefa
    {
        get;
        set
        {
            this.subTipoTarefa = value;
            this.setValueInRecord('TaskSubtype', value);
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

    @AuraEnabled public Datetime dataInicioChamada
    {
        get;
        set
        {
            this.dataInicioChamada = value;
            this.setValueInRecord('DataInicioChamada__c', value);
        }
    }

    @AuraEnabled public Datetime dataCriacao
    {
        get;
        set
        {
            this.dataCriacao = value;
            this.setValueInRecord('CreatedDate', value);
        }
    }

    @AuraEnabled public Datetime dataTerminoChamada
    {
        get;
        set
        {
            this.dataTerminoChamada = value;
            this.setValueInRecord('DataTerminoChamada__c', value);
        }
    }

    @AuraEnabled public String linkAcessarGravacaoChamada
    {
        get;
        set
        {
            this.linkAcessarGravacaoChamada = value;
            this.setValueInRecord('LinkAcessarGravacaoChamada__c', value);
        }
    }

    @AuraEnabled public String ramalUtilizadoChamada
    {
        get;
        set
        {
            this.ramalUtilizadoChamada = value;
            this.setValueInRecord('RamalUtilizadoChamada__c', value);
        }
    }
    
    @AuraEnabled public Decimal duracaoSegundo
    {
        get;
        set
        {
            this.duracaoSegundo = value;
            this.setValueInRecord('DuracaoSegundo__c', value);
        }
    }

    @AuraEnabled public String idNomeRelacionado
    {
        get;
        set
        {
            this.idNomeRelacionado = value;
            this.setValueInRecord('WhoId', value);
        }
    }

    @AuraEnabled public String whatId
    {
        get;
        set
        {
            this.whatId = value;
            this.setValueInRecord('WhatId', value);
        }
    }

    @AuraEnabled public Date dataVencimento
    {
        get;
        set
        {
            this.dataVencimento = value;
            this.setValueInRecord('ActivityDate', value);
        }
    }

    @AuraEnabled public String statusLigacao
    {
        get;
        set
        {
            this.statusLigacao = value;
            this.setValueInRecord('StatusLigacao__c', value);
        }
    }
    
    @AuraEnabled public String ramalTransferencia
    {
        get;
        set
        {
            this.ramalTransferencia = value;
            this.setValueInRecord('RamalTransferencia__c', value);
        }
    }

    @AuraEnabled public Boolean redirecionamentoLigacao
    {
        get;
        set
        {
            this.redirecionamentoLigacao = value;
            this.setValueInRecord('RedirecionamentoLigacao__c', value);
        }
    }

    @AuraEnabled public String ramalRedirecionamentoLigacao
    {
        get;
        set
        {
            this.ramalRedirecionamentoLigacao = value;
            this.setValueInRecord('RamalRedirecionamentoLigacao__c', value);
        }
    }

    //
    //Construtores
    //

    public TaskCallMapper()
    {
        this.subTipoTarefa = 'Call';
    }

    private TaskCallMapper(SObject tarefaChamada)
    {
        initBuild();
        this.construirMapperComSObject(tarefaChamada);
        finishBuild();
    }

    //
    //Métodos
    //

    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new TaskCallMapper((SObject) params);

        return null;
    }

    private void construirMapperComSObject(SObject tarefaChamada)
    {
        this.record = tarefaChamada;
        this.subTipoTarefa = 'Call';

        this.idRegistro = tarefaChamada.Id;
        this.assunto = (String) tarefaChamada.get('Subject');
        this.prioridade = (String) tarefaChamada.get('Priority');
        this.referenciaChamada = (String) tarefaChamada.get('CallObject');
        this.tipoChamada = (String) tarefaChamada.get('CallType');
        this.tipo = (String) tarefaChamada.get('Type');
        this.status = (String) tarefaChamada.get('Status');
        this.idNomeRelacionado = (String) tarefaChamada.get('WhoId');
        this.dataVencimento = (Date) tarefaChamada.get('ActivityDate');

        //Detalhes da chamada
        this.dataInicioChamada = (Datetime) tarefaChamada.get('DataInicioChamada__c');
        this.dataTerminoChamada = (Datetime) tarefaChamada.get('DataTerminoChamada__c');
        this.linkAcessarGravacaoChamada = (String) tarefaChamada.get('LinkAcessarGravacaoChamada__c');
        this.ramalUtilizadoChamada = (String) tarefaChamada.get('RamalUtilizadoChamada__c');
        this.duracaoSegundo = (Decimal) tarefaChamada.get('DuracaoSegundo__c');

        this.dataCriacao = (Datetime) tarefaChamada.get('CreatedDate');
        this.statusLigacao = (String) tarefaChamada.get('StatusLigacao__c');
        this.ramalTransferencia = (String) tarefaChamada.get('RamalTransferencia__c');
        this.redirecionamentoLigacao = (Boolean) tarefaChamada.get('RedirecionamentoLigacao__c');
        this.ramalRedirecionamentoLigacao = (String) tarefaChamada.get('RamalRedirecionamentoLigacao__c');
    }
}