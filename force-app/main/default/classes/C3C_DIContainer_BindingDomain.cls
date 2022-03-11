public class C3C_DIContainer_BindingDomain implements C3C_DI_IProvider{

    public Object newInstance(Object params)
    {
        return new C3C_DIContainer_BindingDomain((SObject) params);
    }

    @AuraEnabled public String recordId {get;set;}

    @AuraEnabled public String keyBinding {get;set;}
    @AuraEnabled public String nomeClasse {get;set;}
    @AuraEnabled public Boolean estatico {get;set;}

    public C3C_DIContainer_BindingDomain(){}
    
    public C3C_DIContainer_BindingDomain(SObject di_binding)
    {
        this.recordId = (String) di_binding.get('Id');

        this.keyBinding = (String) di_binding.get('DeveloperName');
        this.nomeClasse = (String) di_binding.get('ClasseApex__c');
        this.estatico = (Boolean) di_binding.get('Estatico__c');
    }
}