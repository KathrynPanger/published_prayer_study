##############
#Summary Stats
##############
def summarize(*args):
    #dependencies
    import pandas as pd
    import matplotlib.pyplot as plt
    #define arguments
    dataframe=args[0]
    variable= args[1]
    dfvar=dataframe[variable]
    obs=len(dfvar)
    maxvalue=max(dfvar)
    minvalue=min(dfvar)
    Q1=dfvar.quantile(q=0.25)
    Q2=dfvar.quantile(q=0.5)
    Q3=dfvar.quantile(q=0.75)
    mean=dfvar.mean()
    std=dfvar.std()

    summary=pd.DataFrame({'Obs' : [obs], "Max" : [maxvalue], "Min" : [minvalue], "Q1" : [Q1], "Median" : [Q2], "Q3" : [Q3], "Mean" : [mean], "Std" : [std]})
    print(summary)
    print("\n")
    hist=plt.hist(dfvar)
    plt.savefig(f"../figures/Histogram_{variable}.png")
    plt.show()
    print(hist)
##################
#Linear Regression
##################
#Arg 1 = dataset, Args 2-N = "variable" (name in quotes)

def regress(*args):
    #import dependencies
    import sklearn as sk
    from sklearn.linear_model import LinearRegression
    model = LinearRegression()
    from sklearn import feature_selection
    import statsmodels.api as sm
    from patsy import dmatrices

    #define arguments
    dataframe=args[0]
    y=args[1]
    xvars=[]
    for i in range(2,len(args)):
        xvars.append(args[i])
    x = dataframe[[item for item in xvars]]
    y = dataframe[y].values.reshape(-1, 1)
    #fit the model
    model.fit(x,y)

    #Generate Fit Statistics
    ##prep data for patsy
    list=[]
    for item in xvars:
        list.append(f' + {item}')
    string="".join(list)
    newstring=string[3:]

    ind=args[1]
    ind=ind.strip('"')

    ##Get fitstats from patsy
    Y,X = dmatrices(f"{ind} ~ {newstring}", data=dataframe, return_type="dataframe")
    ols = sm.OLS(Y, X)
    ols_result = ols.fit()
    print(ols_result.summary())

    #Plot the Residuals
    print("\n Residual Plot")
    predictions = model.predict(x)
    plt.scatter(predictions, predictions - y, color='coral',linewidths=0.5)
    plt.hlines(y=0, xmin=predictions.min(), xmax=predictions.max(), color='brown', linewidth=3)
    plt.show()

#####################
#Logistic Regression
#####################
#Arg 1 = dataset, Args 2-N = "variable" (name in quotes)

def linregress(*args):
    #import dependencies
    import sklearn as sk
    from sklearn.linear_model import LogisticRegression
    model = LogisticRegression()
    from sklearn import feature_selection
    import statsmodels.api as sm
    from patsy import dmatrices

    #define arguments
    dataframe=args[0]
    y=args[1]
    xvars=[]
    for i in range(2,len(args)):
        xvars.append(args[i])
    x = dataframe[[item for item in xvars]]
    y = dataframe[y]
    #fit the model
    model.fit(x,y)
    
    #Generate Fit Statistics
    ##prep data for patsy
    list=[]
    for item in xvars:
        list.append(f' + {item}')
    string="".join(list)
    newstring=string[3:]

    ind=args[1]
    ind=ind.strip('"')

    ##Get fitstats from patsy
    Y,X = dmatrices(f"{ind} ~ {newstring}", data=dataframe, return_type="dataframe")
    logit = sm.Logit(Y, X)
    logit_result = logit.fit()
    print(logit_result.summary())

    #Plot the Residuals
    print("\n Residual Plot")
    from sklearn.linear_model import Ridge
    from yellowbrick.datasets import load_concrete
    from yellowbrick.regressor import ResidualsPlot
    
    model = Ridge()

    visualizer = ResidualsPlot(model)
    y2= y.values.reshape(-1, 1)
    visualizer.fit(x, y2)  # Fit the training data to the visualizer
    visualizer.score(x, y2)  # Evaluate the model on the test data
    visualizer.show()                 # Finalize and render the figure

    #predictions = model.predict(x)
    #plt.scatter(predictions, predictions - y, color='coral',linewidths=0.5)
    #plt.hlines(y=0, xmin=predictions.min(), xmax=predictions.max(), color='brown', linewidth=3)
    #plt.show()


