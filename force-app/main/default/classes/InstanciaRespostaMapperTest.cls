@isTest
public without sharing class InstanciaRespostaMapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        //WHEN
        String nomeDaAPIObjeto = new InstanciaRespostaMapper().getObjectName();

        //THEN
        System.assertEquals('InstanciaResposta__c', nomeDaAPIObjeto, 'O nome do objeto deveria ser "InstanciaResposta__c"');
    }

    @isTest
    public static void testeNewInstance()
    {
        //WHEN
        InstanciaRespostaMapper instanciaRespostaMpp = (InstanciaRespostaMapper) new InstanciaRespostaMapper().newInstance(Schema.getGlobalDescribe().get(
        	new InstanciaRespostaMapper().getObjectName()
        ).newSObject());

        //THEN
        System.assert(instanciaRespostaMpp != null, 'Deveria retornar uma instância de InstanciaRespostaMapper');
    }
    
    @isTest
    public static void testeNewInstancePassandoMap()
    {
        
        //WHEN
        InstanciaRespostaMapper instanciaRespostaMpp = (InstanciaRespostaMapper) new InstanciaRespostaMapper().newInstance(new Map<String, Object>{
            'idRegistro' => 'teste',
            'idTarefa' => 'teste',
            'pergunta' => 'teste',
            'respostaDissertativa' => 'teste',
            'respostaAlternativa' => 'teste'
        });

        //THEN
        System.assert(instanciaRespostaMpp != null, 'Deveria retornar uma instância de InstanciaRespostaMapper');
    }
}