@isTest
public class BotQueueRouterTest 
{
    @isTest
    static void testInserirFila()
    {
        List<Object> result = BotQueueRouter.inserirFila(new List<BotQueueRouter.QueueInput>{
            new BotQueueRouter.QueueInput()
        });

        System.assert(result.size() > 0, 'A classe deve retornar pelo menos um registro.');
    }
}