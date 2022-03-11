public class BotQueueRouter 
{

  public class QueueOutput {
    @InvocableVariable(required=true)
    public String sQueueNameOutput;
  }

  public class QueueInput {
    @InvocableVariable(required=true)
    public String sQueueNameInput;
  }

  @InvocableMethod(label='Inserir fila')
  public static List<QueueOutput> inserirFila(List<QueueInput> queueInputs) {
      List<QueueOutput> queueOutputReturn = new List<QueueOutput>();
      System.debug(queueInputs);
      for(QueueInput queueInput : queueInputs)
      {
          QueueOutput queueOutput = new QueueOutput();
          queueOutput.sQueueNameOutput = queueInput.sQueueNameInput;
          queueOutputReturn.add(queueOutput);
      }
      
      return queueOutputReturn;    
  }

}