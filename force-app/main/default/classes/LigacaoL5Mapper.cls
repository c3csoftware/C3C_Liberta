public without sharing class LigacaoL5Mapper extends C3C_AbstractMapper
{
    //Método que define o objeto no qual a Mapper é relacionado
    public override String getObjectName()
    {
        return 'LigacoesL5__c';
    }

    //
    //Atributos (Com referência ao campo do objeto)
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

    @AuraEnabled public String ultimoStatusLigacao
    {
        get;
        set
        {
            this.ultimoStatusLigacao = value;
            this.setValueInRecord('UltimoStatusLigacao__c', value);
        }
    }

    @AuraEnabled public String logLicacao
    {
        get;
        set
        {
            this.logLicacao = value;
            this.setValueInRecord('LogLigacao__c', value);
        }
    }

    @AuraEnabled public String ramalUtilizado
    {
        get;
        set
        {
            this.ramalUtilizado = value;
            this.setValueInRecord('RamalUtilizado__c', value);
        }
    }

    @AuraEnabled public String numeroDestino
    {
        get;
        set
        {
            this.numeroDestino = value;
            this.setValueInRecord('NumeroDestino__c', value);
        }
    }

    @AuraEnabled public Datetime dataHoraInicio
    {
        get;
        set
        {
            this.dataHoraInicio = value;
            this.setValueInRecord('DataHoraInicio__c', value);
        }
    }

    @AuraEnabled public Datetime dataHoraTermino
    {
        get;
        set
        {
            this.dataHoraTermino = value;
            this.setValueInRecord('DataHoraTermino__c', value);
        }
    }

    @AuraEnabled public Decimal duracaoSegundos
    {
        get;
        set
        {
            this.duracaoSegundos = value;
            this.setValueInRecord('duracaoSegundos__c', value);
        }
    }

    @AuraEnabled public String linkEscutarGravacao
    {
        get;
        set
        {
            this.linkEscutarGravacao = value;
            this.setValueInRecord('LinkEscutarGravacao__c', value);
        }
    }

    //
    //Construtores
    //

    public LigacaoL5Mapper()
    {}
    
    private LigacaoL5Mapper(SObject ligacaoL5Sobj)
    {
        this.initBuild();
        this.construirMapperComSObject(ligacaoL5Sobj);
        this.finishBuild();
    }

    //
    //Métodos
    //

    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new LigacaoL5Mapper((SObject) params);

        return null;
    }
    
    //Resposável por construir a instância da Mapper a partir de um SObject
    public void construirMapperComSObject(SObject ligacaoL5Sobj)
    {
        this.record = ligacaoL5Sobj;
        
        this.idRegistro = (String) ligacaoL5Sobj.get('Id');
        this.ultimoStatusLigacao = (String) ligacaoL5Sobj.get('UltimoStatusLigacao__c');
        this.logLicacao = (String) ligacaoL5Sobj.get('LogLigacao__c');
        this.ramalUtilizado = (String) ligacaoL5Sobj.get('RamalUtilizado__c');
        this.numeroDestino = (String) ligacaoL5Sobj.get('NumeroDestino__c');
        this.dataHoraInicio = (Datetime) ligacaoL5Sobj.get('DataHoraInicio__c');
        this.dataHoraTermino = (Datetime) ligacaoL5Sobj.get('DataHoraTermino__c');
        this.duracaoSegundos = (Decimal) ligacaoL5Sobj.get('DuracaoSegundos__c');
        this.linkEscutarGravacao = (String) ligacaoL5Sobj.get('LinkEscutarGravacao__c');
    }
}