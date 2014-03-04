# Rails Force.com Canvas

A sample [Force.com Canvas](http://www.salesforce.com/us/developer/docs/platform_connect/canvas_framework.pdf) application using rails 4, [restforce](https://github.com/ejholmes/restforce) and [tunnels](https://github.com/jugyo/tunnels) so you can run https from localhost.

## Connected app setup

The first thing we need to do is create a new Connected App for our Canvas application. Log into your DE org and go to Setup -> Build -> Create -> Apps and click the *New* button at the bottom in the Connected Apps section.

Enter the *Connected App Name* (this is the display name for your app), *API Name* (this is how you'll reference your app) and your *Contact Email*.

Check the *Enable OAuth Setting* checkbox and enter your *Callback URL* as **https://localhost** and for the *Selected OAuth Scopes*, select **Full access (full)**.

In the Canvas App Settings section, check the *Force.com Canvas* checkbox, enter **https://localhost/canvas** for *Canvas App URL*, set *Access Method* to **Signed Request (POST)** and select **Chatter Tab** for *Locations*.

Your resulting app should look something like:

![screenshot](http://blog.jeffdouglas.com/wp-content/uploads/2014/03/canvas-app.png)

Now we need to give your user access to this new app. Go to Setup -> Administrator -> Manage Apps -> Connected App and click the *Edit* link for your new app. Select **Admin approved users are pre-authorized** for *Permitted Users* and save the app. 

The last step is to give your profile access to the app so that it will show up on the Chatter tab. Go to Setup -> Administer -> Manage Users -> Profiles and click the Edit link next to your profile (assumed it's SysAdmin). Now check the box next to your new app in the *Connected App Access* section and save the page.

Now if you click the Chatter tab, you should see your new app in the left sidebar.

## Install the rails-canvas app

Now for the fun part. Let's clone the repo and setup for rails app.

    # clone this repo
    git clone git@github.com:jeffdonthemic/rails-canvas.git
    cd rails-canvas
    # install the required gems
    bundle
    
Now we need to add our the *Consumer Secret* from our Connected app. Go back to your app and click on the **Click to reveal** link to display the secret. Now add this as your client secret for the app in terminal:

    # add the app's secret to the environment
    export CLIENT_SECRET=YOUR-SECRET

## Start the application
    
Canvas apps need to run on https but this makes it difficult to develop and test on your local machine. However, with ruby you can use [tunnels](https://github.com/jugyo/tunnels) to proxy from https from http. In terminal, start your rails server:

    rails s
    
Now open another tab in terminal and fire up tunnels:

    sudo tunnels 443 3000
    
I had some issues using tunnels due to rvm, so I had to use:

    rvmsudo tunnels 443 3000
    
After enter your password, you should see:

#####127.0.0.1:443 --(--)--> 127.0.0.1:3000

You'll want to visit https://localhost in your browser and accept any warning due to a perceived certificate error. This will block your Canvas app from running.

Now you can go to the Chatter tab and access your application from the left sidebar. If everything works correctly, you should see a list of 10 contacts. There's also a page that displays your connection from Force.com.