public without sharing class ChecklistServiceAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod()
    {
        return new Map<String,String>
        {
            'obterListaPeguntaViewModel' => 'ADP_ObterListaPeguntaViewModel',
            'salvarRespostasDaTarefa' => 'ADP_SalvarRespostasDaTarefa'
        };
    }
}