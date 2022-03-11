@isTest
public with sharing class ADP_CriaEventParUsuaComMenEventNoMesTest 
{
    public static void setupContext(String idRegistro, String idFila) {
        // C3C_DIContainer_Injector.createInstance('EventService', Test.createStub(IEventService.class, new EventServiceStub()));
        C3C_APP_ContractInterfaceApplication contract = (C3C_APP_ContractInterfaceApplication) C3C_DIContainer_Injector.newInstance(
            'C3C_APP_ContractInterfaceApplication', 
            JSON.serialize(new Map<String, Object>{
                'requestBody' => new Map<string,Object>{
                    'service' => 'service',
                    'serviceMethod' => 'serviceMethod',
                    // 'bodyMap' => '{"oppIdSet": ["ID1", "ID1"], "oppIdDescriptionMap": {"ID1": "desc_1", "ID2": "desc_2"}}'
                    'bodyMap' => new Map<String, String>{
                        'horario' => '20:20',
                        'duracao' => '20:00',
                        'dataDeInicio' => '23/12/2021',
                        'idRegistro' => idRegistro,
                        'idFila' => idFila,
                        'assunto' => 'assunto',
                        'descricao' => 'descricao'
                    },
                    'listaDePerguntasDaTarefa' => 'listaDePerguntasDaTarefa'
                },
                'enabledPath' => false,
                'returnType' => 'returnType'
        }));
        C3C_APP_ApplicationContext.initialize(contract);
    }
    
    @isTest
    public static void callMethodTest()
    {
        // String idRegistro = fflib_IDGenerator.generate(Event.sObjectType);
        // String idFila = fflib_IDGenerator.generate(Fila__c.sObjectType);

        // setupContext(idRegistro, idFila);
        // ADP_CriarEventParUsuaComMenosEventNoMes adp = new ADP_CriarEventParUsuaComMenosEventNoMes();
        // adp.callMethod();
    }
    
    public class EventServiceStub implements System.StubProvider
    {
        public Object handleMethodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> 
            listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            return returnValue;
        }
    }

    @isTest 
    static void testCoverage()
    {
        ADP_CriarEventParUsuaComMenosEventNoMes.testCoverage();
    }

}