@isTest
public with sharing class CasoTriggerBeforeUpdateServiceTest 
{
    @isTest 
    static void interarVezesQueCasoFoiReabertoTeste()
    {
        // GIVEN
        CasoDomain caso = (CasoDomain) C3C_DIContainer_Injector.newInstance('CasoDomain', Schema.getGlobalDescribe().get('Case').newSObject());

        caso.status = 'Reaberto';
        caso.vezesCasosReaberto = 0;

        // WHEN
        new CasoTriggerBeforeUpdateService().interarVezesQueCasoFoiReaberto(new List<CasoDomain>{
            caso
        });

        // THEN

        System.assert(caso.vezesCasosReaberto == 1, 'A propriedade vezesCasosReaberto deve estar com o valor 1');
    }
}