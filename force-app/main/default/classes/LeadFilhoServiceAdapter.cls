public without sharing class LeadFilhoServiceAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod()
    {
        return new Map<String,String>
        {
            'obterLeadFilhoPorListaIdLeadIdOportunidade' => 'ADP_obterLeadFilhoListaIdLeadIdOport',
            'voltarListaLeadParaFilaCorrespondete' => 'ADP_voltarListaLeadParaFilaCorrespondete'
        };
    }
}