public class C3C_APP_InterfaceApplicationController 
{
	@AuraEnabled
    public static C3C_APP_ContractInterfaceApplication callServiceMethod(String service, String serviceMethod, string bodyJson, Boolean enabledPath, Boolean enabledWarning, String returnType, Boolean paginationAble, Map<Integer, Object> mapPagination)
    {
        //bodyJson = bodyJson.replace('%aspasduplas%', '"');

        System.debug(bodyJson);
        Map<String, Object> bodyObject = String.isBlank(bodyJson) ? new Map<String, Object>() : (Map<String, Object>) JSON.deserializeUntyped(bodyJson);
        C3C_APP_ContractInterfaceApplication contractInstance = (C3C_APP_ContractInterfaceApplication) C3C_DIContainer_Injector.newInstance('C3C_APP_ContractInterfaceApplication', 
                                                                                                             JSON.serialize(new Map<String, Object>{
                                                                                                                'requestBody' => new Map<string,Object>{
                                                                                                                    'service' => service,
                                                                                                                    'serviceMethod' => serviceMethod,
                                                                                                                    'bodyMap' => bodyObject
                                                                                                                },
                                                                                                                'enabledPath' => enabledPath,
                                                                                                                'enabledPath' => enabledWarning,
                                                                                                                'paginationAble' => paginationAble,
                                                                                                                'returnType' => String.isBlank(returnType) ? null : returnType
                                                                                                            }));
        contractInstance.mapPagination = mapPagination;
        return C3C_APP_InterfaceApplicationService.handleServiceMethodCall(contractInstance); 
    }
}