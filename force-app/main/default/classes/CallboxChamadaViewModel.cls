public without sharing class CallboxChamadaViewModel 
{
    //
    //Atributos
    //

    @AuraEnabled public String idTarefaChamada {get;set;}
    @AuraEnabled public String registroRelacionado {get;set;}
    @AuraEnabled public String numeroDestino {get;set;}
    @AuraEnabled public String ramalUtilizado {get;set;}
    @AuraEnabled public Decimal duracaoSegudos {get;set;}
    @AuraEnabled public String dataInicioChamada {get;set;}
    @AuraEnabled public String dataTerminoChamada {get;set;}
    @AuraEnabled public String linkAcessarGravacaoChamada {get;set;}
    @AuraEnabled public String statusChamada {get;set;}
    @AuraEnabled public String direcaoChamada {get;set;}

    //
    //Construtores
    //

    public CallboxChamadaViewModel()
    {}
}