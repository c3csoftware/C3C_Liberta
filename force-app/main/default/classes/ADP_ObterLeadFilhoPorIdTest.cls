@isTest
public with sharing class ADP_ObterLeadFilhoPorIdTest 
{

    public static void setupContext(String idRegistro) 
    {
        C3C_DIContainer_Injector.createInstance('BuscarInfomacoesLeadFilhoService', Test.createStub(BuscarInfomacoesLeadFilhoService.class, new BuscarInfomacoesLeadFilhoServiceStub()));
        C3C_APP_ContractInterfaceApplication contract = (C3C_APP_ContractInterfaceApplication) C3C_DIContainer_Injector.newInstance(
            'C3C_APP_ContractInterfaceApplication', 
            JSON.serialize(new Map<String, Object>{
                'requestBody' => new Map<string,Object>{
                    'service' => 'service',
                    'serviceMethod' => 'serviceMethod',
                    // 'bodyMap' => '{"oppIdSet": ["ID1", "ID1"], "oppIdDescriptionMap": {"ID1": "desc_1", "ID2": "desc_2"}}'
                    'bodyMap' => new Map<String, String>{
                        'idRegistro' => idRegistro
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
        String idRegistro = fflib_IDGenerator.generate(LeadFilho__c.sObjectType);
        
        setupContext(idRegistro);
        ADP_ObterLeadFilhoPorId adp = new ADP_ObterLeadFilhoPorId();
        adp.callMethod();
    }
    
    public class BuscarInfomacoesLeadFilhoServiceStub implements System.StubProvider
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
}