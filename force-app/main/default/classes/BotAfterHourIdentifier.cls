public class BotAfterHourIdentifier
{

  public class BotOutput 
  {
    @InvocableVariable(required=true)
    public Boolean periodoInvalido;
  }

  public class BotInput 
  {
    @InvocableVariable(required=true)
    public String horariosAtendimentoEmString; // 9:00|11:30|1|5
  }

  @InvocableMethod(label='Identificar horário válido de Atendimento')
  public static List<BotOutput> retornarHorarioValido(List<BotInput> botInputs) 
  {
      List<BotOutput> botOutputReturn = new List<BotOutput>();
      
      for(BotInput botInput : botInputs)
      {
          BotOutput botOutput = new BotOutput();
          Boolean horarioInvalido = verificarHorario(botInput.horariosAtendimentoEmString);
          Boolean diaInvalido = verificarDiaDaSemana(botInput.horariosAtendimentoEmString);
          if(horarioInvalido || diaInvalido)
          {
              botOutput.periodoInvalido = true;
          }
          else 
          {
              botOutput.periodoInvalido = false;
          }
          botOutputReturn.add(botOutput);
      }
  	      
      return botOutputReturn;    
  }
    
  private static Boolean verificarHorario(String horarioPermitido)
  {
      DateTime timeDate = DateTime.now();
      Date targetDate = Date.today();
      Time targetTime = Time.newInstance(timeDate.hourGmt(), timeDate.minute(), timeDate.second(), timeDate.millisecond());
      
      TimeZone targetTimezone = TimeZone.getTimeZone('Brazil/East');
      
      Integer offsetSeconds = targetTimezone.getOffset(targetDate) / 1000;
      
      Datetime dt = Datetime.newInstanceGmt(targetDate, targetTime)
          .addSeconds(offsetSeconds);

      String horarioAtualEmGMT = String.valueOf(dt.hourGmt());
      String minutoAtualEmGMT = dt.format('mm');
      Integer horaAtual = Integer.valueOf(horarioAtualEmGMT);
      Integer minutoAtual = Integer.valueOf(minutoAtualEmGMT);
      
      List<String> horariosAtendimento = horarioPermitido.split('\\|');
      Integer horarioInicial = Integer.valueOf(horariosAtendimento[0].split('\\:')[0]);
      Integer horarioFinal = Integer.valueOf(horariosAtendimento[1].split('\\:')[0]);
      Integer minutoInicial = Integer.valueOf(horariosAtendimento[0].split('\\:')[1]);
      Integer minutoFinal = Integer.valueOf(horariosAtendimento[1].split('\\:')[1]);
      
    if(horaAtual >= horarioInicial && horaAtual <= horarioFinal)
	{
        if(horaAtual == horarioFinal && minutoAtual > minutoFinal)
        {
            return true;
        }
        if(horaAtual == horarioInicial && minutoAtual < minutoInicial)
        {
            return true;
        }
    	return false; 
    }
    else
    {
        return true; 
    }
  }
    
  private static Boolean verificarDiaDaSemana(String diasPermitido)
  {
      Date myDateTime = Datetime.now().date();
      Integer dayOfWeek = Math.mod(Date.newInstance(1921, 1, 2).daysBetween(myDateTime),7);
      List<String> diasAtendimento = diasPermitido.split('\\|');
      Integer diaInicial = Integer.valueOf(diasAtendimento[2]);
      Integer diaFinal = Integer.valueOf(diasAtendimento[3]);
      
      if(dayOfWeek >= diaInicial && dayOfWeek <= diaFinal)
      {
          return false;
      }
      else
      {
          return true;
      }
  }
}