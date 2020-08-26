# -*- coding: utf-8 -*-
"""
Created on Tue Oct  2 16:23:44 2018

@author: Gary
"""

import spm1d
import numpy as np
import os
from scipy.io import loadmat
from matplotlib import pyplot
from matplotlib import patches as mp
import pandas as pd

os.chdir('D:\\Users\\Gary\\Google Drive\\Preferred Mass\\Data')

#Data_abs = loadmat('Resample_data_abs.mat')
#
#p_abs = Data_abs['SpmP_abs']
#v_abs = Data_abs['SpmV_abs']
#c_abs = Data_abs['SpmC_abs']
#s_abs = Data_abs['SpmS_abs']
#mean_abs = Data_abs['SpmM_abs']
#
#mean_abs = np.squeeze(mean_abs)
#s_abs=np.squeeze(s_abs)
#c_abs=np.squeeze(c_abs)
#
##V_abs  = spm1d.stats.anova1rm( v_abs[c_abs==1,:], mean_abs[c_abs==1], s_abs[c_abs==1])
#
#z = np.zeros((4,p_abs.shape[1]))
#zstar = np.zeros(4)
##fig1, axes = pyplot.subplots(2,2)
#conditions = [0,3,5,8]
#
#fig1 = pyplot.figure()
### Doing the SPM stuff
#k=1
#mean_abs1 = mean_abs[c_abs==conditions[k-1]]
#v= v_abs[c_abs==conditions[k-1],:]
#v1 = v[mean_abs1==1,:]
#v2 = v[mean_abs1==2,:]
#
#t=spm1d.stats.ttest2(v1,v2)
#ti = t.inference(alpha=0.05, two_tailed=False, interp=True)
#z[k-1,:] = ti.z
#zstar[k-1] = ti.zstar
#
##pyplot.sca(axes.reshape(-1)[k-1])
#pyplot.axvline(next(x[0] for x in enumerate(z[k-1,:]) if x[1] > zstar[0]),color='black')
#print(next(x[0] for x in enumerate(z[0,:]) if x[1] > zstar[0]))
#pyplot.plot(z[k-1,:],color='black')
#
#k=2
#mean_abs1 = mean_abs[c_abs==conditions[k-1]]
#v= v_abs[c_abs==conditions[k-1],:]
#v1 = v[mean_abs1==1,:]
#v2 = v[mean_abs1==2,:]
#
#t=spm1d.stats.ttest2(v1,v2)
#ti = t.inference(alpha=0.05, two_tailed=False, interp=True)
#z[k-1,:] = ti.z
#zstar[k-1] = ti.zstar
#
##pyplot.sca(axes.reshape(-1)[k-1])
#pyplot.axvline(next(x[0] for x in enumerate(z[k-1,:]) if x[1] > zstar[0]),color='yellow')
#print(next(x[0] for x in enumerate(z[0,:]) if x[1] > zstar[0]))
#pyplot.plot(z[k-1,:],color = 'yellow')
#
#k=3
#mean_abs1 = mean_abs[c_abs==conditions[k-1]]
#v= v_abs[c_abs==conditions[k-1],:]
#v1 = v[mean_abs1==1,:]
#v2 = v[mean_abs1==2,:]
#
#t=spm1d.stats.ttest2(v1,v2)
#ti = t.inference(alpha=0.05, two_tailed=False, interp=True)
#z[k-1,:] = ti.z
#zstar[k-1] = ti.zstar
#
##pyplot.sca(axes.reshape(-1)[k-1])
#pyplot.axvline(next(x[0] for x in enumerate(z[k-1,:]) if x[1] > zstar[0]),color='orange')
#print(next(x[0] for x in enumerate(z[0,:]) if x[1] > zstar[0]))
#pyplot.plot(z[k-1,:],color = 'orange')
#
#
#k=4
#mean_abs1 = mean_abs[c_abs==conditions[k-1]]
#v= v_abs[c_abs==conditions[k-1],:]
#v1 = v[mean_abs1==1,:]
#v2 = v[mean_abs1==2,:]
#
#t=spm1d.stats.ttest2(v1,v2)
#ti = t.inference(alpha=0.05, two_tailed=False, interp=True)
#z[k-1,:] = ti.z
#zstar[k-1] = ti.zstar
#
##pyplot.sca(axes.reshape(-1)[k-1])
#pyplot.axvline(next(x[0] for x in enumerate(z[k-1,:]) if x[1] > zstar[0]),color='red')
#print(next(x[0] for x in enumerate(z[0,:]) if x[1] > zstar[0]))
#pyplot.plot(z[k-1,:],color = 'red')
#pyplot.xlabel('Frames (20 = Target Show')
#pyplot.ylabel('Z-Score (>2.71 is sig)')
#os.chdir('D:\\Users\\Gary\\Google Drive\\Preferred Mass\\Python Scripts')
#pyplot.savefig('Z-score compared to beginning mean')
#os.chdir('D:\\Users\\Gary\\Google Drive\\Preferred Mass\\Data')
#
### Plotting the average trajectories
#mean_abs1 = mean_abs[c_abs==0]
#v = v_abs[c_abs==0,:]
#vel1 = v[mean_abs1==1,:]
#vel_mean2 = v[mean_abs1==2,:]
#
#mean_abs2 = mean_abs[c_abs==3]
#v = v_abs[c_abs==3,:]
#vel2 = v[mean_abs2==1,:]
#vel_mean2 = v[mean_abs2==2,:]
#
#mean_abs3 = mean_abs[c_abs==5]
#v = v_abs[c_abs==5,:]
#vel3 = v[mean_abs3==1,:]
#vel_mean3 = v[mean_abs3==2,:]
#
#mean_abs4 = mean_abs[c_abs==8]
#v = v_abs[c_abs==8,:]
#vel4 = v[mean_abs4==1,:]
#vel_mean4 = v[mean_abs4==2,:]
#
#pyplot.figure()
#pyplot.plot(list(range(221)),
#            np.mean(vel1,0),
#            color = 'black',
#            linewidth = 5)
#pyplot.fill_between(list(range(221)),
#                    np.mean(vel1,0)-np.std(vel1,0),
#                    np.mean(vel1,0)+np.std(vel1,0),
#                    alpha = .3,
#                    color = 'black',
#                    linewidth = 0)
#pyplot.plot(list(range(221)),
#            np.mean(vel2,0),
#            color = 'yellow',
#            linewidth = 5)
#pyplot.fill_between(list(range(221)),
#                    np.mean(vel2,0)-np.std(vel2,0),
#                    np.mean(vel2,0)+np.std(vel2,0),
#                    alpha = .3,
#                    color = 'yellow',
#                    linewidth = 0)
#pyplot.plot(list(range(221)),
#            np.mean(vel3,0),
#            color = 'orange',
#            linewidth = 5)
#pyplot.fill_between(list(range(221)),
#                    np.mean(vel3,0)-np.std(vel3,0),
#                    np.mean(vel3,0)+np.std(vel3,0),
#                    alpha = .3,
#                    color = 'orange',
#                    linewidth = 0)
#pyplot.plot(list(range(221)),
#            np.mean(vel4,0),
#            color = 'red',
#            linewidth = 5)
#pyplot.fill_between(list(range(221)),
#                    np.mean(vel4,0)-np.std(vel4,0),
#                    np.mean(vel4,0)+np.std(vel4,0),
#                    alpha = .3,
#                    color = 'red',
#                    linewidth = 0)
#pyplot.ylabel('Velocity (m/s)')
#pyplot.xlabel('Frames (20 = Target Show')
#os.chdir('D:\\Users\\Gary\\Google Drive\\Preferred Mass\\Python Scripts')
#pyplot.savefig('Average velocity traces')
#os.chdir('D:\\Users\\Gary\\Google Drive\\Preferred Mass\\Data')

# ====================== SPM against min jerk =================================
def min_jerk_vel(tm):
  ro = 0
  rf = 0.1
  dt=0.005
  
  tme=np.arange(0,tm,dt)
  ts=tme/tm
  
  t2=ts*ts
  t3=t2*ts
  t4=t3*ts
#  t5=t4*ts
  
  v=((60*t3-30*t4-30*t2)/tm)*(ro-rf)
  return(v)

os.chdir('C:\\Users\\Gary\\Google Drive\\Preferred Mass')

file_location = r'C:\Users\Gary\Google Drive\Preferred Mass\NewData_noFML_test.csv'
df = pd.read_csv(file_location)
eff_masses = pd.read_csv(r'C:\Users\Gary\Google Drive\Preferred Mass\eff_masses.csv',header=None)

#data = df.query('reaction_tanv<100').query('movedur<1.5')
data = df.query('odd_trial==1').query('trial>50')
del df

data['peakv_to_endpt'] = [row.idxendpt-row.idxpeakv for index,row in data.iterrows()]
data['onset_to_peakv'] = [row.idxpeakv-row.idxonset for index,row in data.iterrows()]
data['odd_target'] = [row.targetnum%2 for index,row in data.iterrows()]
data['vthresh_dur'] = 0.005*(data.vthres_endpt-data.vthres_onset)

#plot_data=data.\
#    query('miss_dist<.03').\
#    query('odd_trial==1').\
#    query('pathlall<.12').\
#    query('onset_to_peakv<200').\
#    query('pathlall>.09').\
#    query('maxex<.13')

os.chdir('D:\\Users\\Gary\\Google Drive\\Preferred Mass\\Data')

Data_abs = loadmat('Resample_data_abs2.mat')

p_abs = Data_abs['SpmP_abs']
v_abs = Data_abs['SpmV_abs']
c_abs = Data_abs['SpmC_abs']
s_abs = Data_abs['SpmS_abs']
mean_abs = Data_abs['SpmM_abs']

mean_abs = np.squeeze(mean_abs)
s_abs=np.squeeze(s_abs)
c_abs=np.squeeze(c_abs)

#pyplot.figure( figsize=(16, 9) )
fig, ax = pyplot.subplots(2,4)
fig.suptitle('Red is actual data, black is simulated min jerk', fontsize=14)
locs = [[0.1 ,.6, .175, .35],[0.3, .6, .175, .35],[0.5, .6, .175, .35],[0.7, .6, .175, .35],
        [0.1 ,.1, .175, .35],[0.3, .1, .175, .35],[0.5, .1, .175, .35],[0.7, .1, .175, .35]]

count = 1
for c in [0,3,5,8]:
    v1 = v_abs[c_abs==c]
    
    #v2=min_jerk_vel(np.mean(data.query('condition==0').movedur))
    v3 = np.zeros([np.size(v1[:,1]),321])
    v2_lengthmax = 0
    for k in np.arange(2100):
        rand_n = 0.001*np.random.randn(1)
        if data.query('condition == '+str(c)).iloc[k].movedur < 300*0.005:
            v2=min_jerk_vel(data.query('condition == '+str(c)).iloc[k].movedur)
        else:
            v2=min_jerk_vel(300*0.005)
        v2_lengthmax = np.max([v2_lengthmax,len(v2)])
        v3[k,:] = np.concatenate([np.zeros(20),
                       v2,
                       np.zeros(321-20-np.size(v2))]).T
        v3[k,:] = v3[k,:]+rand_n
    v1 = v1[:,20:v2_lengthmax]
    v3 = v3[:,20:v2_lengthmax]
    print('Done creating min jerk profiles: c='+str(c))
    t  = spm1d.stats.ttest2(v1,v3)
    ti = t.inference(alpha=0.05, two_tailed=False, interp=True)
    #ti.plot()
    
    print('SPM done: c='+str(c))
    
#    ax[2*c-1]     = pyplot.axes(locs[2*count-1])
    pyplot.sca(ax[0,count-1])
    spm1d.plot.plot_mean_sd(v3)
    spm1d.plot.plot_mean_sd(v1, linecolor='r', facecolor='r')
    red_patch = mp.Patch(color='red', label='Real Data')
    black_patch = mp.Patch(color='black', label='Min Jerk Sim')
    pyplot.legend(handles=[red_patch,black_patch])
    
#    ax[2*c]     = pyplot.axes(locs[2*count])
    pyplot.sca(ax[1,count-1])
    ti.plot()
    ti.plot_threshold_label(fontsize=8)
    count += 1

### Do spm against a 0 condition to try and get at reaction time

# =============================================================================
# 
#   ## This section was for the spm, didn't work out
# Data_norm = loadmat('Resample_data.mat')
#   
# p_norm = Data_norm['SpmP']
# v_norm = Data_norm['SpmV']
# c_norm = Data_norm['SpmC']
# s_norm = Data_norm['SpmS']
# 
# s_norm = np.transpose(s_norm)
# c_norm = np.transpose(c_norm)
# 
# s_norm=np.squeeze(s_norm)
# c_norm=np.squeeze(c_norm)
# 
# V_norm  = spm1d.stats.anova1rm( v_norm, c_norm, s_norm, equal_var=True )
# P_norm  = spm1d.stats.anova1rm( p_norm, c_norm, s_norm, equal_var=True )
# 
# Vi_norm = V_norm.inference(alpha=0.05)
# Pi_norm = P_norm.inference(alpha=0.05)
# 
# fig1, (ax1,ax2) = pyplot.subplots(2,1)
# 
# pyplot.sca(ax1)
# Pi_norm.plot()
# pyplot.sca(ax2)
# Vi_norm.plot()
# 
# ax1.set_ylabel('F Stat - Position')
# ax2.set_ylabel('F Stat - Velocity')
# ax1.set_title('Normalized Frames')
# 
# os.chdir('D:\\Users\\Gary\\Google Drive\\Preferred Mass\\Python Scripts')
# fig1.savefig('Normalized_spm.png')
# 
# 
# os.chdir('D:\\Users\\Gary\\Google Drive\\Preferred Mass\\Data')
# Data_abs = loadmat('Resample_data_abs.mat')
# 
# p_abs = Data_abs['SpmP_abs']
# v_abs = Data_abs['SpmV_abs']
# c_abs = Data_abs['SpmC_abs']
# s_abs = Data_abs['SpmS_abs']
# mean_abs = Data_abs['SpmM_abs']
# 
# s_abs = np.transpose(s_abs)
# c_abs = np.transpose(c_abs)
# 
# s_abs=np.squeeze(s_abs)
# c_abs=np.squeeze(c_abs)
# 
# v_abs2 = v_abs
# 
# V_abs  = spm1d.stats.anova1rm( v_abs, c_abs, s_abs, equal_var=True )
# P_abs  = spm1d.stats.anova1rm( p_abs, c_abs, s_abs, equal_var=True )
# 
# Vi_abs = V_abs.inference(alpha=0.05)
# Pi_abs = P_abs.inference(alpha=0.05)
# 
# fig2, (ax21,ax22) = pyplot.subplots(2,1)
# 
# pyplot.sca(ax21)
# Pi_abs.plot()
# pyplot.sca(ax22)
# Vi_abs.plot()
# 
# ax21.set_ylabel('F Stat - Position')
# ax22.set_ylabel('F Stat - Velocity')
# ax21.set_title('Absolute Frames')
# 
# 
# os.chdir('D:\\Users\\Gary\\Google Drive\\Preferred Mass\\Python Scripts')
# fig2.savefig('Absolute_spm.png')
# 
# 
# #for k in range(len(c_abs)):
# #    if c_abs[k] == 1:
# #        c_abs[k] = 2.5
# #    if c_abs[k] == 2:
# #        c_abs[k] = 3.8
# #    if c_abs[k] == 3:
# #        c_abs[k] = 4.7
# #    if c_abs[k] == 4:
# #        c_abs[k] = 6.1
# 
# #for k in range(len(c_abs)):
# #    v_abs2[k,:] = c_abs[k]*v_abs[k,:]
# 
# #
# #V_abs  = spm1d.stats.anova1rm( v_abs2, c_abs, s_abs, equal_var=True )
# #P_abs  = spm1d.stats.anova1rm( p_abs2, c_abs, s_abs, equal_var=True )
# x=np.linspace(1,251,251)
# pyplot.figure()
# for k in np.arange(1,5):
# #    pyplot.fill_between(x,np.mean(v_abs[c_abs==k,:].T,1)+np.std(v_abs[c_abs==k,:].T,1),'--',np.mean(v_abs[c_abs==k,:].T,1)-np.std(v_abs[c_abs==k,:].T,1),'--')
#     pyplot.plot(np.mean(v_abs[c_abs==k,:].T,1))
#     pyplot.plot(np.mean(v_abs[c_abs==k,:].T,1)+np.std(v_abs[c_abs==k,:].T,1),'--')
#     pyplot.plot(np.mean(v_abs[c_abs==k,:].T,1)-np.std(v_abs[c_abs==k,:].T,1),'--')
# =============================================================================
