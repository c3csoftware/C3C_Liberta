public without sharing class EventRelationServiceAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod()
    {
        return new Map<String,String>
        {
            'criarRelacaoDoEvento' => 'ADP_CriarRelacaoDoEvento'
        };
    }
}