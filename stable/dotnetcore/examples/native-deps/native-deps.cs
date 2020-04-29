using System;
using Kubeless.Functions;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Data.SqlClient;

public class module
{
    const string FAKE_CONN_STRING = "Server=FAKEHOST;Database=FAKEDB;User Id=sa;Password=FAKEPWD;Trusted_Connection=False;MultipleActiveResultSets=True;Persist Security Info=True;Connect Timeout=1";
    public Task<object> handler(Event k8Event, Context k8Context)
    {
        var optionsBuilder = new DbContextOptionsBuilder<DbContext>();
        var options = optionsBuilder.UseSqlServer(FAKE_CONN_STRING).Options;
        var dbCtx = new DbContext(options);
        try {
            var canConnect = dbCtx.Database.CanConnect();
        } catch (SqlException exc) {
            // It's all right, FAKEHOST does not exist :)
        }
        return Task.FromResult<object>("Okay native-deps");
    }
}
