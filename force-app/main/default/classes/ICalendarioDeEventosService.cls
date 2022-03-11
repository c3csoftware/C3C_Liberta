public interface ICalendarioDeEventosService 
{
    List<AgendaDoUsuarioViewModel> obterAgendaDeUsuariosDaFilaDurantePeriodo(String idFila, Datetime dataHoraInicioPeriodo, Datetime dataHoraTerminoPeriodo); //Método resposável por retornar a agenda de eventos de todos os usuário da fila no periodo informado.
    Map<String, List<EventMapper>> obterAgendaDeUsuariosDaFilaSemUsuariosInformadosDurantePeriodo(String idFila, Set<String> idsUsuario, Datetime dataHoraInicioPeriodo, Datetime dataHoraTerminoPeriodo); //Método resposável por retornar a agenda de eventos de todos os usuário no periodo informado.
}