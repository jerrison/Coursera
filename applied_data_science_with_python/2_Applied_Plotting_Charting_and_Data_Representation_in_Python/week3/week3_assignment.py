
# coding: utf-8

# In[32]:


# Use the following data for this assignment:

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

np.random.seed(12345)

df = pd.DataFrame([np.random.normal(32000,200000,3650), 
                   np.random.normal(43000,100000,3650), 
                   np.random.normal(43500,140000,3650), 
                   np.random.normal(48000,70000,3650)], 
                  index=[1992,1993,1994,1995])


# In[33]:


df2 = df.mean(axis=1)


# In[34]:


df2.plot.bar(color=['b', 'r', 'w', 'r']
            , edgecolor='k').axhline(df2.iloc[2])

plt.show()

