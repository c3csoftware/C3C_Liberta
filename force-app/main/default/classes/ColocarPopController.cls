public class ColocarPopController 
{
    @AuraEnabled
    public static List<TipoTarefa__c> obterPop(String pop)
    {        
        return [SELECT Id, DescricaoPop__c FROM TipoTarefa__c WHERE PerfilCliente__c =: pop];
    }
}