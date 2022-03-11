public without sharing class C3C_TriggerConfigDomain extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    public override String getObjectName()
    {
        return 'C3C_Trigger_Config__c';
    }

    //Atributos
    @AuraEnabled public String recordId {get;set;}

    @AuraEnabled public String name {get;set;}

    @AuraEnabled public Boolean isActive = false;
    @AuraEnabled public Boolean isAfterDelete = false;
    @AuraEnabled public Boolean isAfterInsert = false;
    @AuraEnabled public Boolean isAfterUnDelete = false;
    @AuraEnabled public Boolean isAfterUpdate = false;
    @AuraEnabled public Boolean isBeforeDelete = false;
    @AuraEnabled public Boolean isBeforeInsert = false;
    @AuraEnabled public Boolean isBeforeUpdate = false;

    //Construtores
    public C3C_TriggerConfigDomain()
    {}
    
    private C3C_TriggerConfigDomain(SObject c3cTriggerConfig)
    {
        this.initBuild();
        this.buildFromRecord(c3cTriggerConfig);
        this.finishBuild();
    }

    //Métodos
    public Object newInstance(Object params)
    {
        return new C3C_TriggerConfigDomain((SObject) params);
    }
    
    private void buildFromRecord(SObject c3cTriggerConfig)
    {
        this.record = c3cTriggerConfig;
        
        this.recordId = (String) c3cTriggerConfig.get('Id');

        this.name = (String) c3cTriggerConfig.get('Name');

        this.isActive = (Boolean) c3cTriggerConfig.get('isActive__c');
        this.isAfterDelete = (Boolean) c3cTriggerConfig.get('isAfterDelete__c');
        this.isAfterInsert = (Boolean) c3cTriggerConfig.get('isAfterInsert__c');
        this.isAfterUnDelete = (Boolean) c3cTriggerConfig.get('isAfterUnDelete__c');
        this.isAfterUpdate = (Boolean) c3cTriggerConfig.get('isAfterUpdate__c');
        this.isBeforeDelete = (Boolean) c3cTriggerConfig.get('isBeforeDelete__c');
        this.isBeforeInsert = (Boolean) c3cTriggerConfig.get('isBeforeInsert__c');
        this.isBeforeUpdate = (Boolean) c3cTriggerConfig.get('isBeforeUpdate__c');
    }
}