public class checkProductBatchScheduler {
	public static String CRON_EXP = '0 0 0/2 1/1 * ? *';
    public void execute() 
    {
        checkProductBatch obj=new checkProductBatch();
        String jobID = system.schedule('Check Product Batch',CRON_EXP, obj);
    }
}