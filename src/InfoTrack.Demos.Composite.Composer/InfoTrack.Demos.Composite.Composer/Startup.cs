﻿using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace InfoTrack.Demos.Composite.Composer
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                options.CheckConsentNeeded = context => true;
                options.MinimumSameSitePolicy = SameSiteMode.None;
            });
            
            services.AddMvc()
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_1);

            //var redis = ConnectionMultiplexer.Connect("redis");
            //services.AddDataProtection()
            //    .PersistKeysToRedis(redis, "DataProtection-Keys");
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseStaticFiles();
            app.UseCookiePolicy();

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "/",
                    defaults: new { controller = "Home", action = "Index", type = "file", fragment = "/home.html" } );
              
                routes.MapRoute(
                    name: "netcoremvcapp",
                    template: "/netcoremvcapp",
                    defaults: new { controller = "Home", action = "Index", type = "virtual", fragment = "/fragments/netcoremvcapp/" } );

                routes.MapRoute(
                    name: "netframeworkmvcapp",
                    template: "/netframeworkmvcapp",
                    defaults: new { controller = "Home", action = "Index", type = "virtual", fragment = "/fragments/netframeworkmvcapp/" } );
            });
        }
    }
}
