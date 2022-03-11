public without sharing class CalendarioDeEventosServiceAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod()
    {
        return new Map<String,String>
        {
            'obterAgendaDeUsuariosDaFilaDurantePeriodo' => 'ADP_ObterAgendaUsuariosFilaDurPer'
        };
    }
}