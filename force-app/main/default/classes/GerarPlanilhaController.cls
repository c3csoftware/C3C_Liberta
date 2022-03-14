public without sharing class GerarPlanilhaController 
{
    @AuraEnabled
    public static void mandarPlanilhaPorEmail(String emailUsuario, Datetime dataInicial, Datetime dataFinal){
        try {
            GerarPlaninha.gerarPlanilhaHunter(emailUsuario, dataInicial, dataFinal);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}