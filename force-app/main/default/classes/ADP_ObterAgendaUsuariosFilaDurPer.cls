public with sharing class ADP_ObterAgendaUsuariosFilaDurPer extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        String dataDeInicioFormatacao = mapParams.get('dataDeInicio').replace('T', ' ').left(19);
        String dataDeTerminoFormatacao = mapParams.get('dataDeTermino').replace('T', ' ').left(19);

        ((ICalendarioDeEventosService) C3C_DIContainer_Injector.getInstance('CalendarioDeEventosService')).obterAgendaDeUsuariosDaFilaDurantePeriodo(
            (String) mapParams.get('idFila'),
            DateTime.valueOf(dataDeInicioFormatacao),
            DateTime.valueOf(dataDeTerminoFormatacao)
        );
    }
}