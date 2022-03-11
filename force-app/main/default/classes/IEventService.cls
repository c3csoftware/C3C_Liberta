public interface IEventService 
{
    List<IEventDomain> buscarEventosDeUsuariosDaFilaComDataDeInicioETermino(String idFila, Datetime dataDeInicio, Datetime dataDeTermino); //Responsável por retornar os evento dos usuários da fila informada, a partir da data de inicio e termino informada.

    // Comentado para verificar se passa no
    IEventDomain criarEventoParaUsuarioComMenosEventoNoMes(Id idRegistro, String idFila, Date dataDeInicio, Time horario, Time duracao, String assunto, String descricao);
    // void verificarAssessorIndicado(Id idRegistro);
    List<IEventDomain> atualizarEvento(List<IEventDomain> listaEvento); //Método responsável por atualizar eventos.
    List<EventMapper> obterEventosDoMesComIdRelativoIdProprietario(String idRelativo, String idProprietario);
    //Responsável por retornar os evento dos usuários informados, a partir da data de inicio e termino informada.
    List<IEventDomain> buscarEventosDeUsuariosDaFilaSemUsuariosInformadosComDataDeInicioETermino(String idFila, Set<String> idsUsuario, Datetime dataDeInicio, Datetime dataDeTermino);
}