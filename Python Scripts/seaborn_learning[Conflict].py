# -*- coding: utf-8 -*-
"""
Created on Wed Oct 17 22:15:03 2018

@author: Gary
"""

import os
import seaborn as sns
import pandas as pd
import numpy as np
from matplotlib import pyplot as plt
import time

os.chdir('C:\\Users\\Gary\\Google Drive\\Preferred Mass')
plt.close("all")

file_location = r'C:\\Users\\Gary\Google Drive\\Preferred Mass\\NewData_noFML.csv'
df = pd.read_csv(file_location)
eff_masses = pd.read_csv(r'C:\Users\Gary\Google Drive\Preferred Mass\eff_masses.csv',header=None)

data = df.query('reaction_tanv<100').query('movedur<1.5')

a = data.query('odd_trial==1').groupby(['condition','subj'])['movedur'].mean().reset_index()

plt.figure()
sns.lineplot(x='condition',
             y='movedur',
             hue='subj',
             data=a)
sns.violinplot(x='condition',
               y='movedur',
               data=data.query('odd_trial==1'),
               palette = ['yellow','white','white','orange','white','red','white','white','brown'],
               order=np.arange(9),
               width=2,
               inner=None)
plt.axis([-1.5,9.5,0.3,1.6])

plt.figure()
sns.violinplot(x='condition',
               y='reaction_tanv',
               data=data.query('odd_trial==1'),
               palette = ['yellow','orange','red','brown'])

#for index,row in data.iterrows():
#    data['eff_mass2'] = eff_masses.values[[0,3,5,8].index(int(row.condition)),int(row.subj)-1]

data['eff_mass2'] = [eff_masses.values[[0,3,5,8].index(int(row.condition)),int(row.subj)-1] for index,row in data.iterrows()]

fig, ax = plt.subplots()
b = data.query('odd_trial==1').groupby(['eff_mass2','subj'])['movedur'].mean().reset_index()
cmap = sns.color_palette('hls',12)
sns.lineplot(x='eff_mass2',y='movedur',hue='subj',data=b,palette = cmap)
sns.scatterplot(x='eff_mass2',y='movedur',hue='subj',s=100,data=b,palette = cmap)
ax.legend_.remove()


#fig, ax = plt.subplots()
#ax = sns.kdeplot(data.query('condition==8').movedur,
#                 data.query('condition==8').reaction_tanv,
#                 cmap='Reds',
#                 shade=True,
#                 shade_lowest=False)


