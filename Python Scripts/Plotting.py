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
from scipy.io import loadmat
from matplotlib import lines as mlines
from matplotlib import patches as mp
#import time

os.chdir('C:\\Users\\Gary\\Google Drive\\Preferred Mass')
plt.close("all")

file_location = r'C:\Users\Gary\Google Drive\Preferred Mass\NewData_noFML.csv'
df = pd.read_csv(file_location)
eff_masses = pd.read_csv(r'C:\Users\Gary\Google Drive\Preferred Mass\eff_masses.csv',header=None)

data = df.query('reaction_tanv<100').query('movedur<1.5')

data['peakv_to_endpt'] = [row.idxendpt-row.idxpeakv for index,row in data.iterrows()]
data['onset_to_peakv'] = [row.idxpeakv-row.idxonset for index,row in data.iterrows()]
data['odd_target'] = [row.targetnum%2 for index,row in data.iterrows()]
data['vthresh_dur'] = 0.005*(data.vthres_endpt-data.vthres_onset)

plot_data=data.\
    query('miss_dist<.03').\
    query('odd_trial==1').\
    query('pathlall<.12').\
    query('onset_to_peakv<200').\
    query('pathlall>.09').\
    query('maxex<.13')

a = data.query('odd_trial==1').groupby(['condition','subj'])['movedur'].mean().reset_index()
b=data\
    .query('odd_trial==1')\
    .groupby(['condition',
              'odd_target',
              'subj'])\
             ['movedur',
              'peakvel_target',
              'pathlall',
              'miss_dist']\
     .mean()\
     .reset_index()

#plt.figure()
#sns.lineplot(x='condition',
#             y='movedur',
#             hue='subj',
#             data=a)
#sns.violinplot(x='condition',
#               y='movedur',
#               data=data.query('odd_trial==1'),
#               palette = ['yellow','white','white','orange','white','red','white','white','brown'],
#               order=np.arange(9),
#               width=2,
#               inner=None)
#plt.axis([-1.5,9.5,0.3,1.6])
#
#a=data[['movedur','condition','odd_trial']].query('odd_trial==1').copy()
#a['Onset'] = 'Gary'
#b=data[['vthresh_dur','condition','odd_trial']].query('odd_trial==1').copy().rename(index=str,columns={'vthresh_dur':'movedur'})
#b['Onset'] = 'V_thresh'
#c=pd.concat([a,b])
#plt.figure()
#sns.violinplot(x='condition',
#               y='movedur',
#               data=c,
#               hue='Onset',
#               order=np.arange(9),
#               width=2,
#               split=True,
#               inner=None)
#plt.axis([-1.5,9.5,0,1.6])
#
#plt.figure()
#sns.violinplot(x='condition',
#               y='reaction_tanv',
#               data=data.query('odd_trial==1'),
#               palette = ['yellow','orange','red','brown'])
#
##for index,row in data.iterrows():
##    data['eff_mass2'] = eff_masses.values[[0,3,5,8].index(int(row.condition)),int(row.subj)-1]
#
#data['eff_mass2'] = [eff_masses.values[[0,3,5,8].index(int(row.condition)),int(row.subj)-1] for index,row in data.iterrows()]
#
#fig, ax = plt.subplots()
#b = data.query('odd_trial==1').groupby(['eff_mass2','subj'])['movedur'].mean().reset_index()
#cmap = sns.color_palette('hls',12)
#sns.lineplot(x='eff_mass2',y='movedur',hue='subj',data=b,palette = cmap)
#sns.scatterplot(x='eff_mass2',y='movedur',hue='subj',s=100,data=b,palette = cmap)
#ax.legend_.remove()
#
#fig, ax = plt.subplots()
#ax=sns.lmplot(x='reaction_tanv',
#              y='movedur',
#              data=data.query('miss_dist<0.01').query('odd_trial==1'),
#              scatter = False)
#ax=sns.scatterplot(x='reaction_tanv',
#                   y='movedur',
#                   hue='miss_dist',
#                   size='miss_dist',
#                   data=data.query('miss_dist<.01').query('odd_trial==1'))

#==============================================================================
# Odd Target Stuff
#fig,ax=plt.subplots()
#sns.scatterplot(x='peakvel_target',
#                y='movedur',
#                hue='pathlall',
#                size='miss_dist',
#                style='odd_target',
#                data=plot_data)
#fig,ax=plt.subplots()
#sns.scatterplot(x='peakvel_target',
#                y='onset_to_peakv',
#                hue='pathlall',
#                size='miss_dist',
#                style='odd_target',
#                data=plot_data)
#fig,ax=plt.subplots()
#sns.scatterplot(x='peakvel_target',
#                y='peakv_to_endpt',
#                hue='pathlall',
#                size='miss_dist',
#                style='odd_target',
#                data=plot_data)
#fig,ax=plt.subplots()
#sns.scatterplot(x='peakvel_target',
#                y='vthresh_dur',
#                hue='condition',
#                style='odd_target',
#                data=plot_data.query('vthresh_dur>0'))
      
fig,ax = plt.subplots()
ax.scatter(x=data.movedur,y=data.sumVx,c='red',s=3)
ax.scatter(x=data.movedur,y=data.sumVx_pdiff,c='blue',s=3)
ax.set_xlabel('Movement Duration')
ax.set_ylabel('Integral of Velocity Profiles')
handles, labels = ax.get_legend_handles_labels()
ax.legend(handles, labels,loc='upper right')

sns.scatterplot(x='movedur',y='sumVx_orig',hue='targetnum',data=data.query('odd_trial==1'),palette="Set2")
sns.scatterplot(x='movedur',y='sumVx_pdiff',color='black',data=data.query('odd_trial==1'))

#yellow_patch = mp.Patch(color='yellow', label='Vx_robot')
#black_patch = mp.Patch(color='black', label='Vx_pdiff')
#plt.legend(handles=[yellow_patch,black_patch])

#==============================================================================
# Average Trace Plotting

os.chdir('D:\\Users\\Gary\\Google Drive\\Preferred Mass\\Data')
Data_strings = ['Resample_data_pilot_abs.mat','Resample_data_smallt_abs.mat','Resample_data_abs2.mat']
titles = ['Pilot Data','Small Target Data','Current Data']
#for k, item in enumerate(Data_strings):
item = Data_strings[2]
k=2
Data_abs = loadmat(item)

p_abs = Data_abs['SpmP_abs']
v_abs = Data_abs['SpmV _abs']
c_abs = Data_abs['SpmC_abs']
s_abs = Data_abs['SpmS_abs']
t_abs = Data_abs['SpmT_abs']
mean_abs = Data_abs['SpmM_abs']

mean_abs = np.squeeze(mean_abs)
s_abs=np.squeeze(s_abs)
c_abs=np.squeeze(c_abs)
t_abs=np.squeeze(t_abs)

conditions = [0,3,5,8]
colors = ['black','gold','orange','red']

fig,axes = plt.subplots(2,2)#,sharex=True,sharey=True)

solid_line = mlines.Line2D([],[],color='black')
dashed_line = mlines.Line2D([],[],color='black',linestyle='dashed')

for i, ax in enumerate(fig.axes):
    v_c0_te = v_abs[((c_abs==conditions[i]) & (t_abs%2==1)),:]
    v_c0_to = v_abs[((c_abs==conditions[i]) & (t_abs%2==0)),:]
    ax.plot(list(range(321)),
               np.mean(v_c0_te,0),
               color = colors[i])
    ax.plot(list(range(321)),
               np.mean(v_c0_to,0),
               '--',
               color = colors[i])

plt.figlegend([solid_line,dashed_line],('Even Target','Odd Target'),'upper right')
fig.text(0.5,0.95,titles[k],ha='center')
fig.text(0.5,0.04,'Frame (20 = Target Show)',ha='center')
fig.text(0.04,0.5,'Velocity (m/s)',va='center',rotation='vertical')

fig,axes = plt.subplots(2,2)#,sharex=True,sharey=True)

solid_line = mlines.Line2D([],[],color='black')
dashed_line = mlines.Line2D([],[],color='black',linestyle='dashed')

for i, ax in enumerate(fig.axes):
    p_c0_te = p_abs[((c_abs==conditions[i]) & (t_abs%2==1)),:]
    p_c0_to = p_abs[((c_abs==conditions[i]) & (t_abs%2==0)),:]
    ax.plot(list(range(321)),
               np.mean(p_c0_te,0),
               color = colors[i])
    ax.plot(list(range(321)),
               np.mean(p_c0_to,0),
               '--',
               color = colors[i])

plt.figlegend([solid_line,dashed_line],('Even Target','Odd Target'),'upper right')
fig.text(0.5,0.95,titles[k],ha='center')
fig.text(0.5,0.04,'Frame (20 = Target Show)',ha='center')
fig.text(0.04,0.5,'Position (m)',va='center',rotation='vertical')
    
#==============================================================================
# Alpha Modeling Plot

model_alpha = pd.read_csv(r'C:\Users\Gary\Google Drive\Preferred Mass\Modeled_alpha.csv')

#sns.scatterplot(x='peakvel_target',
#                y='vthresh_dur',
#                hue='condition',
#                style='odd_target',
#                data=plot_data.query('vthresh_dur>0'))

cmap = sns.color_palette('hls',12)
#sns.lineplot(x='eff_mass2',y='movedur',hue='subj',data=b,palette = cmap)

eff_masses = [2.5,3.8,4.7,6.1]
model_alpha['eff_mass'] = [eff_masses[int(row.condition)-1] for index,row in model_alpha.iterrows()]
fig, ax = plt.subplots()
g = sns.lineplot(x='eff_mass',y='movedur',hue='subj',style='model',data=model_alpha,palette = cmap)
g.legend(loc='upper left')
g.set(xticks=(2.5,3.8,4.7,6.1))
os.chdir('D:\\Users\\Gary\\Google Drive\\Muscle Modeling\\Metabolics\\Graphs')
fig.savefig('alphafits_individual.eps',format='eps')


sns.lineplot(x='condition',y='movedur',hue='subj',style='model',data=model_alpha.query('subj==6'))





