({
    doInit : function(component, event, helper) 
    {
        var utilityAPI = component.find("utilitybar");
        utilityAPI.getAllUtilityInfo().then(function(response) 
        {
            $A.get("e.force:closeQuickAction").fire();

            if(!response)
                return;

            let utilityTelefoniaIndex = response.findIndex(x => x.utilityLabel == 'Telefonia');

            if(utilityTelefoniaIndex >= 0)
            {
                let utilityTelefonia = response[utilityTelefoniaIndex];

                utilityAPI.openUtility({
                    utilityId: utilityTelefonia.id
                });

                let callboxAuraEvent = $A.get("e.c:CallboxAuraEvent");

                callboxAuraEvent.setParams({
                    acao: 'LigarPaginaDetalhes',
                    parametros: {
                        telefone: !!component.get('v.leadRecord.MobilePhone') ? component.get('v.leadRecord.MobilePhone') : component.get('v.leadRecord.Phone'),
                        registroRelacionado: component.get('v.recordId')
                    }
                });

                callboxAuraEvent.fire();
            }
        })
        .catch(function(error) {
            console.log(error);
        });
    }
})