# -*- coding: utf-8 -*-
"""
Created on Wed Oct 17 22:15:03 2018

@author: Gary
"""

import os
import seaborn as sns
import pandas as pd

os.chdir('C:\\Users\\Gary\\Google Drive\\Preferred Mass')

file_location = r'C:\Users\Gary\Google Drive\Preferred Mass\NewData_noFML.csv'
df = pd.read_csv(file_location)

sns.catplot(x='movedur',y='reaction_tanv',hue='condition',data=df)

df.groupby(['subj','condition'])['movedur'].mean()