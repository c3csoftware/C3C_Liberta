public without sharing virtual class PendingServiceRoutingMapper extends C3C_AbstractMapper implements C3C_DI_IProvider 
{
    //
    // -- C3C Gerada pelo Gerador de Código --
    //

    public override String getObjectName()
    {
        return 'PendingServiceRouting';
    }

    //
    //Atributos
    //
    @AuraEnabled public String recordId
    {
        get;
        set{
           this.recordId = value;
           this.setValueInRecord('Id', value);
        }
    }
    @AuraEnabled public String ownerId
    {
        get;
        set{
           this.ownerId = value;
           this.setValueInRecord('OwnerId', value);
        }
    }
    @AuraEnabled public String workItemId
    {
        get;
        set{
           this.workItemId = value;
           this.setValueInRecord('WorkItemId', value);
        }
    }
    @AuraEnabled public Boolean isPushed
    {
        get;
        set{
           this.isPushed = value;
           this.setValueInRecord('IsPushed', value);
        }
    }

    //
    //Construtores
    //

    public  PendingServiceRoutingMapper(){}

    private  PendingServiceRoutingMapper(SObject pendingserviceroutingObj )
    {
        this.initBuild();
        this.construirMapperComSObject(pendingserviceroutingObj);
        this.finishBuild();
    }


    //
    //Métodos
    //

    public Object newInstance(Object params )
    {
        if(params instanceOf SObject)
            return new PendingServiceRoutingMapper((SObject) params);
        return null;
    }

    private void construirMapperComSObject(SObject pendingserviceroutingObj )
    {
        this.record = pendingserviceroutingObj;

        this.recordId = (String) pendingserviceroutingObj.get('Id');
        this.ownerId = (String) pendingserviceroutingObj.get('OwnerId');
        this.workItemId = (String) pendingserviceroutingObj.get('WorkItemId');
        this.isPushed = (Boolean) pendingserviceroutingObj.get('IsPushed');
    }
}